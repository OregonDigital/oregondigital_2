require 'active_fedora/noid'

ActiveFedora::Noid.configure do |config|
  config.statefile = ENV['NOID_STATEFILE'] || Rails.root.join("tmp", "minter-state-#{Rails.env}")
  config.template = '.reeddeeddk'
end
