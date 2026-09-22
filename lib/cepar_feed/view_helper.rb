module CeparFeed
  module ViewHelper
    def render_feed_banner
      # fetch data using core gem method
      feed_data = CeparFeedBanner.read_cached_feed

      # Rails.logger.info "=======CEPAR FEED DEBUG========="
      # Rails.logger.info "RAW FETCH RESULT; #{feed_data.inspect}"

         # If it's empty, this prints a warning inside your server log panel
      if feed_data.blank?
        Rails.logger.warn "!!! CeparFeedBanner cache is completely empty !!!"
        return nil
      end
      # return nil if feed_data.blank?
      # if feed_data.blank?
      #   return nil
      # end

      # Rails.logger.info "SUCCESS - out[utting html cpntent]"
      # Rails.logger.info "=================================================="

      #safely construct HTML output tags
      # content_tag(:div, class: 'cepar-feed-banner', id: 'cepar-live-banner') do
      #   content_tag(:span, "Emergency Update: ", class: 'banner-label') +
      #   link_to(title, link, target:'_blank', rel: 'noopener noreferrer', class: 'banner-link')

       # Wrap your raw snippet inside a container div for layout scoping
      # tag.div(class: 'cepar-message', id: 'emory-cepar-text') do
        # Mark the internal string as html_safe so browser reads the <p> tags correctly
        # raw(feed_data)
      # end
# def render_fetched_text(feed_data)
    # html_content = raw(feed_data)
    # parsed_html = Nokogiri::HTML.fragment(html_content)# Use .fragment for snippets!
    # parsed_html.at_css("p")&.text
# end
# Extract the text cleanly from the paragraph
      # specific_text = parsed_html.at_css("p")&.text || parsed_html.text

      # specific_text.strip

   # 1. ULTIMATE BYPASS FIX: Strip HTML tags using standard Rails 'strip_tags'
      # Since your string is just a simple paragraph, this extracts the pure text safely!
      specific_text = action_view_helper.strip_tags(feed_data)

      # 2. If it's still blank for some reason, return the raw data so you see SOMETHING
      specific_text.presence || feed_data
    end

    private

    # Helper method to access standard view helpers safely inside a lib context
    def action_view_helper
      @action_view_helper ||= ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    end

      # rescue StandardError => e
      #   Rails.logger.error("[CeparFeedBanner] View Helper failed to render: #{e.message}")
      #   nil # fail silently so it doesn't break everyyting else
      # end
    end
  end