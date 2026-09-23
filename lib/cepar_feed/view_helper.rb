module CeparFeed
  module ViewHelper
    def render_feed_banner
      # pull text from the file store
      feed_data = CeparFeedBanner.read_cached_feed

      return nil if feed_data.blank?

      # extracts the pure text safely
      specific_text = action_view_helper.strip_tags(feed_data)
      # Clean up any trailing spaces or newlines
      specific_text.strip
    end

    private

    # Helper method to access standard view helpers safely inside a lib context
    def action_view_helper
      @action_view_helper ||= ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    end

  end
end