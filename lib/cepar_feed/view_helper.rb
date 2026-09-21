module CeparFeed
  module ViewHelper
    def render_feed_banner
      # fetch data using core gem method
      feed_data = CeparFeedBanner.fetch_feed
      # return nil if feed_data.nil?

      # Rails.logger.info "=======CEPAR FEED DEBUG========="
      # Rails.logger.info "RAW FETCH RESULT; #{feed_data.inspect}"

      if feed_data.blank?
        return nil
      end

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
    html_content = raw(feed_data)
    parsed_html = Nokogiri::HTML(html_content)
    specific_text = parsed_html.at_css("p")&.text
# end

      rescue StandardError => e
        Rails.logger.error("[CeparFeedBanner] View Helper failed to render: #{e.message}")
        nil # fail silently so it doesn't break everyyting else
      end
    end
  end