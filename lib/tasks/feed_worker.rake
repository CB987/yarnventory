namespace :cepar_feed do
  desc "runs efficient, non-blocking 5-second background loop to refresh feed"
  task run_worker: :environment do
    Rails.logger.info "[CeparFeed Worker] starting CeparFeed background monitoring daemon"

    loop do
      start_time = Time.now

      # perform network fetch and update shared cache
      begin
        CeparFeedBanner.fetch_and_cache_feed
      rescue => e
        # prevent global loop from fracturing due to deep core exceptions
        Rails.logger.error "[CeparFeed Worker Daemon Exception]: #{e.message}"
      end

      # dynamically calculate sleep time to account for network latency
      elapsed = Time.now - start_time
      sleep_duration = [5.0 - elapsed, 0.1].max

      sleep(sleep_duration)
    end
  end
end