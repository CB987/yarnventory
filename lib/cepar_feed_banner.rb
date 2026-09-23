require 'yaml'
require_relative 'cepar_feed/feed_processor'
require_relative 'cepar_feed/view_helper'

module CeparFeedBanner

  # hardcoding cepar url as default.
  # DEV FEED FOR TESTING
  DEFAULT_FEED_URL = "https://template.aws.emory.edu/shared-assets/emergency/alert-feed-dev.php"
  # PROD FEED
  # DEFAULT_FEED_URL = "https://template.aws.emory.edu/shared-assets/emergency/alert-feed.php"
  DEFAULT_FORMAT = :html # (would be false for xml rss feed)

  class << self
    # these accessors allow the values to be read or overridden
    attr_writer :feed_url, :feed_format

    def feed_url
      @feed_url || DEFAULT_FEED_URL
    end

    def feed_format
      @feed_format || DEFAULT_FORMAT
    end

    def banner_file_path
      # Memoize the absolute file path so it evaluates dynamically on boot, but doesn't reconstruct the string on every single 5-second interval.
      @banner_file_path ||= File.expand_path(File.join(File.dirname(__FILE__), "..", "tmp", "cepar_global_banner.yml"))
    end

    # 1. This is what the view helper calls
    def read_cached_feed
      path = banner_file_path
      (File.exist?(path) && File.size(path) > 0) ? File.read(path) : nil
    rescue => e
      Rails.logger.error "CeparFeedBanner read Failed #{e.message}"
      nil
    end

    #  asynchronous process called by Rake loop
    def fetch_and_cache_feed
      # FIRST hits the feed processor module to get the raw HTML data
      feed_data = CeparFeed::FeedProcessor.process(feed_url, format: feed_format)
      path = banner_file_path

      if feed_data.present?
        # In active emergency, Securely dump the raw HTML string straight into the shared text file
        File.write(path, feed_data)
        # puts "Worker found active alert and updated the banner file at: #{Time.now}"
        feed_data
      else
        # all clear, no endpoint data, so banner doesn't render
        File.delete(path) if File.exist?(path)
        # puts "cepar alert cleared. removing banner file at #{Time.now}"
        nil
      end

    # THEN infrastructure fallbacks (only trigger if the connection actually breaks)
    rescue SocketError, Timeout::Error => e
      # Connection dropped. retain whatever we had on disk so a live alert isn't lost due to downtime
      Rails.logger.error "[CeparFeedBanner] endpoint unreachable: #{e.message}. retaining cache state"
      read_cached_feed
    rescue => e
      # unexpected code crash
      Rails.logger.error "[CeparFeedBanner] unexpected background failure: #{e.message}. retaining cache state"
      read_cached_feed
    end
  end
end

if defined?(Rails::Railtie)
  class Railtie < Rails::Railtie
    initializer "cepar_feed_banner.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        # THIS LINE is what connects your view_helper.rb
      # to your HTML views so `<%= render_feed_banner %>` functions!
        include CeparFeed::ViewHelper
      end
    end
  end
end