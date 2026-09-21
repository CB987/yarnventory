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

  # fetch method that uses shipped url
  def self.fetch_feed
    if defined?(Rails) && Rails.cache
      # 1. Check a short-lived cache first (5s)
      # this prevents concurrent users from separate requests
      Rails.cache.fetch("cepar_feed:global_banner", expires_in: 5.seconds) do
        CeparFeed::FeedProcessor.process(feed_url, format: feed_format)
     end
    else
      CeparFeed::FeedProcessor.process(feed_url, format: feed_format)
    end
  end

  if defined?(Rails::Railtie)
    class Railtie < Rails::Railtie
      initializer "cepar_feed_banner.view_helpers" do
        ActiveSupport.on_load(:action_view) do
          include CeparFeed::ViewHelper
        end
      end
    end
  end
end