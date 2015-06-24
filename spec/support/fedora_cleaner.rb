require 'active_fedora/cleaner'
RSpec.configure do |c|
  c.before do
    if ActiveFedora::Base.all.count > 0
      ActiveFedora::Cleaner.clean!
    end
  end
end
