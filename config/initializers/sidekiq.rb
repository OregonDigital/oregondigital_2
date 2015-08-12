Sidekiq.configure_server do |config|
  config.redis = { namespace: "oregondigital2"}
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => "oregondigital2"}
end
