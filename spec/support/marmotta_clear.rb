RSpec.configure do |config|
  config.before(:each) do
    OregonDigital.marmotta.delete_all
  end
end
