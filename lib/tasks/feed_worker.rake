namespace :cepar_feed do
  desc "runs efficient, non-blocking 5-second background loop to refresh feed"
  task run_worker: :environment do
    puts "starting CeparFeed background worker"

    loop do
      start_time = Time.now

      # perform network fetch and update shared cache
      CeparFeedBanner.fetch_and_cache_feed

      # dynamically claculate sleep time to account for network latency
      elapsed = Time.now - start_time
      sleep_duration = [5.0 - elapsed, 0.1].max

      sleep(sleep_duration)
    end
  end
end