require 'net/http'
require 'uri'
# require 'rss'
require 'json'

module CeparFeedBanner
  class FeedProcessor
    def self.process(url, is_json:false)
      uri = URI.parse(url)

      #  Net::HTTP.get_response handles SSL automatically in modern Ruby
      response = Net::HTTP.get_response(uri)
      return nil unless response.is_a?(Net::HTTPSuccess)

      if is_json
        # Parse native JSON string into a Ruby Hash/Array
        JSON.parse(response.body)
      else
        # Parse XML/RSS string into structured Ruby objects
        RSS::Parser.parse(response.body, false)
      end
    rescue StandardError => e
      # error handling
      defined?(Rails) ? Rails.logger.error("Gem Error:  #{e.message}") : warn(e.message)
      nil
    end
  end
end