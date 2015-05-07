require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability do
  subject { Ability.new(user) }
  context "when given a user" do
    let(:user) { FactoryGirl.build(:user) }
    it "should not be an admin" do
      expect(user).not_to be_admin
    end
  end
  context "when given an admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }
    it "should be an admin" do
      expect(user).to be_admin
    end
    it "should be able to manage everything" do
      expect(subject).to be_able_to(:manage, :all)
    end
  end
end
