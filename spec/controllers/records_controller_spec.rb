require 'rails_helper'

RSpec.describe RecordsController do
  let(:form) { instance_double(ImageForm) }
  let(:template) { FactoryGirl.build(:form_template, :with_title, :with_desc) }
  let(:template_class) { class_double(FormTemplate) }

  before do
    allow(controller).to receive(:template_class).and_return(template_class)
    sign_in FactoryGirl.create(:user, :admin)
  end

  describe "#ingest_options" do
    let(:options) { [["title", 1], ["title 2", 2]] }
    before do
      expect(controller).to receive(:template_select_options).and_return(options)
    end

    it "should offer all templates' names and ids" do
      get :ingest_options
      expect(assigns[:templates]).to include(options.first)
    end

    it "should include a 'raw' option for the template list" do
      get :ingest_options
      expect(assigns[:templates]).to include(["Raw (no template)", nil])
    end
  end

  describe "#new" do
    before do
      allow(ImageForm).to receive(:new).and_return(form)
      allow(template_class).to receive(:find_by_id).and_return(nil)
      allow(form).to receive(:template=).with(nil)
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
      let(:template) { instance_double(FormTemplate) }
      before do
        allow(template_class).to receive(:find_by_id).with("1").and_return(template)
      end

      it "should attach template 1 to the form" do
        expect(form).to receive(:template=).with(template)
        get :new, :type => "Image", :template_id => 1
      end
    end
  end

  describe "#edit" do
    let(:obj) { Image.new }
    before do
      @routes = HydraEditor::Engine.routes
      allow(ActiveFedora::Base).to receive(:find).with("1").and_return(obj)
      allow(ImageForm).to receive(:new).and_return(form)
      allow(template_class).to receive(:find_by_id).and_return(nil)
      allow(form).to receive(:template=).with(nil)
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
      let(:template) { instance_double(FormTemplate) }
      before do
        allow(template_class).to receive(:find_by_id).with("1").and_return(template)
      end

      it "should attach template 1 to the form" do
        expect(form).to receive(:template=).with(template)
        get :edit, :template_id => 1, :id => 1
      end
    end
  end
end
