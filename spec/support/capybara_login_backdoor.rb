# gives us the login_as(@user) method when request object is not present
RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end
end
RSpec.configure do |config|
  config.after(:each) { Warden.test_reset! }
end

module CapybaraBackdoorHelpers
  # Will run the given code as the user passed in
  def as_user(user=nil, &block)
    current_user = user || FactoryGirl.create(:user)
    if defined?(request) && request.present?
      sign_in(current_user)
    else
      login_as(current_user, :scope => :user)
    end
    block.call if block.present?
    return self
  end
end

RSpec.configure do |config|
  config.include CapybaraBackdoorHelpers
end
