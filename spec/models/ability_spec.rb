require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability do
  subject { Ability.new(user) }
  context "when given a user" do
    let(:user) { FactoryGirl.build(:user) }
    it { should_not be_able_to(:create, GenericAsset) }
  end
  context "when given an admin" do
    let(:user) { FactoryGirl.build(:admin) }
    it { should be_able_to(:create, GenericAsset) }
  end
end
