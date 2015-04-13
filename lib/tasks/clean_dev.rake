require 'active_fedora/cleaner'

desc "Destroy all ActiveFedora assets"
task "fedora:delete" => :environment do |t, args|
  unless Rails.env.development? || Rails.env.test?
    raise "ERROR: Fedora cleaner will not run unless in development or test environment"
  end

  if ActiveFedora::Base.all.count > 0
    ActiveFedora::Cleaner.clean!
  end
end
