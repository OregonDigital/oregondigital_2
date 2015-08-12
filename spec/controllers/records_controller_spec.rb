require 'rails_helper'

RSpec.describe RecordsController do
  let(:form) { instance_double(GenericAssetForm) }
  let(:template1) { FactoryGirl.build(:form_template, :with_title, :with_desc) }
  let(:template2) { FactoryGirl.build(:form_template, :with_title) }
  let(:templates) { [template1, template2] }

  before do
    sign_in FactoryGirl.create(:user, :admin)
    allow(template1).to receive(:id).and_return(1)
    allow(template2).to receive(:id).and_return(2)
    allow(FormTemplate).to receive(:all).and_return(templates)
    allow(FormTemplate).to receive(:find).with(1).and_return(template1)
    allow(controller).to receive(:build_form).and_return(form)
  end

  describe "#ingest_options" do
    it "should offer all templates' names and ids" do
      get :ingest_options
      expect(assigns[:templates]).to include([template1.title, template1.id], [template2.title, template2.id])
    end

    it "should include a 'raw' option for the template list" do
      get :ingest_options
      expect(assigns[:templates]).to include(["Raw (no template)", nil])
    end
  end

  describe "#new" do
    before do
      @routes = HydraEditor::Engine.routes
    end

    it "should render the new form template" do
      get :new, :type => "Image"
      expect(response).to render_template "records/new"
    end

    it "should build the form" do
      expect(controller).to receive(:build_form).once.and_return(form)
      get :new, :type => "Image"
    end

    it "should assign the form" do
      get :new, :type => "Image"
      expect(assigns[:form]).to eq(form)
    end

    context "with a template id" do
      it "should attach template 1 to the form" do
        expect(form).to receive(:template=).with(template1)
        get :new, :type => "Image", :template_id => 1
      end
    end
  end

  describe "#edit" do
    let(:obj) { double("Object") }
    before do
      @routes = HydraEditor::Engine.routes
      allow(ActiveFedora::Base).to receive(:find).with("1").and_return(obj)
    end

    it "should render the edit form template" do
      get :edit, :id => 1
      expect(response).to render_template "records/edit"
    end

    it "should build the form" do
      expect(controller).to receive(:build_form).once.and_return(form)
      get :edit, :id => 1
    end

    it "should assign the form" do
      get :edit, :id => 1
      expect(assigns[:form]).to eq(form)
    end

    context "with a template id" do
      it "should attach template 1 to the form" do
        expect(form).to receive(:template=).with(template1)
        get :edit, :template_id => 1, :id => 1
      end
    end
  end
end
