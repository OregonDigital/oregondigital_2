require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability do
  subject { Ability.new(user) }
  context "when given a user" do
    let(:user) { FactoryGirl.build(:user) }
    it "should not be an admin" do
      expect(user).not_to be_admin
    end
    it "should not be able to edit a SolrDocument instance" do
      expect(subject).not_to be_able_to(:edit, SolrDocument.new)
    end
  end
  context "when given an admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }
    it { should be_able_to(:create, GenericAsset) }
    it "should be an admin" do
      expect(user).to be_admin
    end
    it "should be able to manage everything" do
      expect(subject).to be_able_to(:manage, :all)
    end
    it "should be able to edit a SolrDocument instance" do
      expect(subject).to be_able_to(:edit, SolrDocument.new)
    end
  end
end
