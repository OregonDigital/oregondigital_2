require 'rails_helper'

RSpec.describe Admin::FormTemplatesController do
  render_views
  let(:template_class) { class_double("FormTemplate") }

  before do
    allow(controller).to receive(:template_class).and_return(template_class)
  end

  context "when not an admin" do
    it "should not be allowed" do
      get :index

      expect(response).to be_redirect
      expect(flash["error"]).to eq "You do not have sufficient permissions to view this page"
    end
  end

  context "when an admin" do
    before do
      sign_in FactoryGirl.create(:user, :admin)
    end

    describe "#index" do
      it "should get all templates" do
        templates = [build_template(:id => 1), build_template(:id => 2)]
        expect(template_class).to receive(:all).once.and_return(templates)
        get :index

        expect(response).to render_template "form_templates/index"
        expect(assigns[:templates]).to eq(templates)
      end
    end

    describe "#new" do
      let(:new_template) { build_template }
      before do
        allow(controller).to receive(:terms).and_return(["foo", "bar", "baz"])
        expect(template_class).to receive(:new).and_return(new_template)
      end

      it "should render the form" do
        get :new
        expect(response).to render_template "form_templates/new"
        expect(response).to render_template "form_templates/_form"
      end

      it "should set up all terms on the template" do
        get :new
        expect(new_template.properties.length).to eq(3)
        expect(new_template.properties.collect {|p| p.name}).to eq(["foo", "bar", "baz"])
      end
    end

    describe "#create" do
      let(:form_params) { Hash.new }
      let(:new_template) { build_template }
      before do
        allow(controller).to receive(:form_template_params).and_return(form_params)
        allow(template_class).to receive(:new).with(form_params).and_return(new_template)
        allow(new_template).to receive(:save).and_return(success)
      end

      context "when creation succeeds" do
        let(:success) { true }

        it "should redirect with notification" do
          post :create, form_params
          expect(response).to be_redirect
          expect(flash["success"]).not_to be_empty
        end
      end

      context "when creation fails" do
        let(:success) { false }

        it "should re-render the form" do
          post :create, form_params
          expect(response).to render_template "form_templates/new"
          expect(response).to render_template "form_templates/_form"
        end

        it "should notify the user" do
          post :create, form_params
          expect(flash["alert"]).not_to be_empty
        end
      end
    end

    describe "#edit" do
      let(:template) { build_template }
      before do
        expect(template_class).to receive(:find).with("1").and_return(template)
      end

      it "should render the form" do
        get :edit, :id => 1
        expect(response).to render_template "form_templates/edit"
        expect(response).to render_template "form_templates/_form"
      end
    end

    describe "#update" do
      let(:form_params) { Hash.new }
      let(:template) { build_template }
      before do
        allow(controller).to receive(:form_template_params).and_return(form_params)
        expect(template_class).to receive(:find).with("1").and_return(template)
        allow(template).to receive(:update_attributes).and_return(success)
      end

      context "when update succeeds" do
        let(:success) { true }

        it "should redirect with notification" do
          put :update, :id => 1
          expect(response).to be_redirect
          expect(flash["success"]).not_to be_empty
        end
      end

      context "when update fails" do
        let(:success) { false }

        it "should re-render the form" do
          put :update, :id => 1
          expect(response).to render_template "form_templates/edit"
          expect(response).to render_template "form_templates/_form"
        end

        it "should notify the user" do
          put :update, :id => 1
          expect(flash["alert"]).not_to be_empty
        end
      end
    end

    describe "#destroy" do
      let(:template) { build_template }
      before do
        expect(template_class).to receive(:find).with("1").and_return(template)
        expect(template).to receive(:destroy).and_return(success)
      end

      context "when destroy succeeds" do
        let(:success) { true }

        it "should redirect with success notification" do
          delete :destroy, :id => 1
          expect(response).to be_redirect
          expect(flash["success"]).not_to be_empty
        end
      end

      context "when destroy fails" do
        let(:success) { false }

        it "should redirect with an error notification" do
          delete :destroy, :id => 1
          expect(response).to be_redirect
          expect(flash["alert"]).not_to be_empty
        end
      end
    end
  end

  def build_template(args = {})
    FormTemplate.new(args)
  end
end
