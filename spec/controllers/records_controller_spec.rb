require 'rails_helper'

RSpec.describe RecordsController do
  let(:form) { instance_double(ImageForm) }
  let(:template1) { FactoryGirl.build(:form_template, :with_title, :with_desc) }
  let(:template2) { FactoryGirl.build(:form_template, :with_title) }
  let(:templates) { [template1, template2] }
  let(:template_class) { class_double(FormTemplate) }

  before do
    allow(controller).to receive(:template_class).and_return(template_class)
    sign_in FactoryGirl.create(:user, :admin)
  end

  describe "#ingest_options" do
    before do
      allow(template_class).to receive(:all).and_return(templates)
    end

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
      before do
        allow(template_class).to receive(:find_by_id).with("1").and_return(template1)
      end

      it "should attach template 1 to the form" do
        expect(form).to receive(:template=).with(template1)
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
      before do
        allow(template_class).to receive(:find_by_id).with("1").and_return(template1)
      end

      it "should attach template 1 to the form" do
        expect(form).to receive(:template=).with(template1)
        get :edit, :template_id => 1, :id => 1
      end
    end
  end
end
