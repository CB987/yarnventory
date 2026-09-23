require 'net/http'
require 'uri'
require 'rss'
require 'json'

module CeparFeed
  class FeedProcessor
    def self.process(url, format: :html)
      uri = URI.parse(url)

      # configure safe networking limits for high-frequency polling
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      http.open_timeout = 2 # seconds to open connection
      http.read_timeout = 2 # seconds to wait for data

      request = Net::HTTP::Get.new(uri)
      response = http.request(request)

      # Temporary addition inside lib/cepar_feed/feed_processor.rb
      return nil unless response.is_a?(Net::HTTPSuccess)

      # ADD THIS LINE TEMPORARILY TO SEE WHAT THE PHP ENDPOINT IS ACTUALLY SAYING:
      # puts "!!! RAW ENDPOINT RESPONSE: #{response.body}"

      case format
      when :html
        # strip trailing newlines or spaces and return raw string content directly
        response.body.strip
      when :json
        # Parse native JSON string into a Ruby Hash/Array
        JSON.parse(response.body);
      else
        # Parse XML/RSS string into structured Ruby objects
        RSS::Parser.parse(response.body, false)
      end
    rescue StandardError => e
      # error handling
      defined?(Rails) ? puts("[CeparFeedBanner] Fetch Failed:  #{e.message}") : warn(e.message)
      nil
    end

  end
end