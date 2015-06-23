require_relative 'production'

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'od2-dev.library.oregonstate.edu' }
end
