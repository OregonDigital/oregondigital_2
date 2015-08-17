require 'rails_helper'

RSpec.describe Admin::IpBasedGroupsController, :type => :controller do
  let(:group) { instance_double(IpBasedGroup) }
  let(:group2) { instance_double(IpBasedGroup) }
  let(:groups) { [group, group2] }
  let(:roles) { [instance_double(Role)] }
  before do
    allow(IpBasedGroup).to receive(:all).and_return(groups)
    allow(IpBasedGroup).to receive(:new).and_return(group)
    allow(Role).to receive(:all).and_return(roles)
  end

  describe "#index" do
    it "should assign groups" do
      expect(IpBasedGroup).to receive(:all).once.and_return(groups)
      get :index
      expect(assigns[:ip_based_groups]).to eq(groups)
    end

    it "should render the index" do
      get :index
      expect(response).to render_template "ip_based_groups/index"
    end
  end

  describe "#new" do
    it "should build a group" do
      expect(IpBasedGroup).to receive(:new).once
      get :new
    end

    it "should assign the group" do
      get :new
      expect(assigns[:ip_based_group]).to eq(group)
    end

    it "should render the new form" do
      get :new
      expect(response).to render_template "ip_based_groups/new"
    end
  end

  describe "#create" do
    let(:params) do
      { :ip_based_group => {:title => "foo"} }
    end
    let(:success) { true }
    before do
      allow(group).to receive(:save).and_return(success)
    end

    it "should build a group from params" do
      expect(IpBasedGroup).to receive(:new).with(:title => "foo")
      post :create, params
    end

    it "should save the group" do
      expect(group).to receive(:save)
      post :create, params
    end

    context "when save succeeds" do
      it "should redirect" do
        post :create, params
        expect(response).to be_redirect
      end
    end

    context "when save fails" do
      let(:success) { false }

      it "should repopulate roles" do
        post :create, params
        expect(assigns[:roles]).to eq(roles)
      end

      it "should render the new form" do
        post :create, params
        expect(response).to render_template "ip_based_groups/new"
      end
    end
  end
end
