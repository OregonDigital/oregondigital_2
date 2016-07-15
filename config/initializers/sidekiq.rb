if ENV['JOB_WORKER_URL']
  sidekiq_config = {
    namespace: "oregondigital2",
    url: ENV['JOB_WORKER_URL']
  }
else
  sidekiq_config = { namespace: "oregondigital2" }
end

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
