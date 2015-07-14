require 'rails_helper'

RSpec.describe LDPathConfiguration, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:path) }
end
