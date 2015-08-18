require 'rails_helper'

RSpec.describe Admin::IpBasedGroupsController, :type => :controller do
  let(:group) { instance_double(IpBasedGroup) }
  let(:saved_group) { instance_double(IpBasedGroup) }
  let(:groups) { [group, saved_group] }
  let(:roles) { [instance_double(Role)] }
  before do
    sign_in FactoryGirl.create(:user, :admin)
    allow(IpBasedGroup).to receive(:all).and_return(groups)
    allow(IpBasedGroup).to receive(:new).and_return(group)
    allow(IpBasedGroup).to receive(:find).and_return(saved_group)
    allow(controller).to receive(:all_roles).and_return(roles)
  end

  context "when not an admin" do
    it "should not be allowed" do
      sign_in FactoryGirl.create(:user)
      get :index

      expect(response).to be_redirect
      expect(flash["error"]).to eq "You do not have sufficient permissions to view this page"
    end
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

  describe "#edit" do
    it "should find a group" do
      expect(IpBasedGroup).to receive(:find).once.with("1")
      get :edit, :id => 1
    end

    it "should assign the group" do
      get :edit, :id => 1
      expect(assigns[:ip_based_group]).to eq(saved_group)
    end

    it "should render the edit form" do
      get :edit, :id => 1
      expect(response).to render_template "ip_based_groups/edit"
    end
  end

  describe "#update" do
    let(:params) do
      { :id => 1, :ip_based_group => {:title => "updated foo"} }
    end
    let(:success) { true }
    before do
      allow(saved_group).to receive(:update_attributes).and_return(success)
    end

    it "should find the group" do
      expect(IpBasedGroup).to receive(:find).with("1")
      patch :update, params
    end

    it "should update the group from params" do
      expect(saved_group).to receive(:update_attributes).with(:title => "updated foo")
      patch :update, params
    end

    context "when save succeeds" do
      it "should redirect" do
        patch :update, params
        expect(response).to be_redirect
      end
    end

    context "when save fails" do
      let(:success) { false }

      it "should repopulate roles" do
        patch :update, params
        expect(assigns[:roles]).to eq(roles)
      end

      it "should render the edit form" do
        patch :update, params
        expect(response).to render_template "ip_based_groups/edit"
      end
    end
  end
end
