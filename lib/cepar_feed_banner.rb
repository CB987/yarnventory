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
  end

  # 1. This is what the view helper calls
  def self.read_cached_feed
    if defined?(Rails) && Rails.cache
      # 1. Check a short-lived cache first (5s)
      # this prevents concurrent users from separate requests
      Rails.cache.read("cepar_feed_banner:global_banner") || fetch_and_cache_feed
      puts "looked at cache here"
    else
      CeparFeed::FeedProcessor.process(feed_url, format: feed_format)
    end
  end
  
  #  this is what the Rake worker calls 
  def self.fetch_and_cache_feed
    #  hits the feed processor module to get the raw HTML data
    feed_data = CeparFeed::FeedProcessor.process(feed_url, format: feed_format)

    if defined?(Rails) && Rails.cache
      # Cache it indefinitely (or with a long expiry) because the worker updates it
      Rails.cache.write("cepar_feed_banner:global_banner", feed_data, expires_in: 1.hour)
      puts "fetched new here"
    end
  
    feed_data
    rescue => e
      Rails.logger.error "CeparFeedBanner Background Sync Failed: #{e.message}"
      nil
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
end