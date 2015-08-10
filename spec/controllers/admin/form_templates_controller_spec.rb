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
    let(:template1) { instance_double("FormTemplate") }
    let(:template2) { instance_double("FormTemplate") }
    before do
      sign_in FactoryGirl.create(:user, :admin)
    end

    describe "#index" do
      it "should get all templates" do
        expect(template_class).to receive(:all).once.and_return([template1, template2])
        get :index

        expect(response).to render_template "form_templates/index"
        expect(assigns[:templates]).to eq([template1, template2])
      end
    end
  end
end
