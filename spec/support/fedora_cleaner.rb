require 'active_fedora/cleaner'
require_relative 'webmock'
RSpec.configure do |c|
  c.before do
    ActiveFedora::Cleaner.clean!
  end
end
