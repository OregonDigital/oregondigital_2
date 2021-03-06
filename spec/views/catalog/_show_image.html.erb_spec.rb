require 'rails_helper'

RSpec.describe "catalog/_show_image" do
  let(:document) { SolrDocument.new(resource.to_solr) }
  before do
    allow(view).to receive(:document).and_return(document)
    allow(view).to receive(:openseadragon_picture_tag)
    stub_template "catalog/_show_default.html.erb" => "Default Stuff"
    render
  end

  context "When it has no image" do
    let(:resource) { build_resource }

    it "should render default stuff" do
      expect(rendered).to have_content "Default Stuff"
      expect(response).to render_template "catalog/_show_default"
    end
    it "should have no image tag" do
      expect(rendered).not_to have_selector("img")
    end
  end

  context "When it has a medium image only" do
    let(:resource) { build_resource(medium: true) }

    it "should render default stuff" do
      expect(rendered).to have_content "Default Stuff"
      expect(response).to render_template "catalog/_show_default"
    end
    it "should have an image tag" do
      expect(rendered).to have_selector("img[src='/media/medium-images/t/s/test.jpg']")
    end
  end

  context "When it has a pyramidal and medium image" do
    let(:resource) { build_resource(medium: true, pyramidal: true) }

    it "should render default stuff" do
      expect(rendered).to have_content "Default Stuff"
      expect(response).to render_template "catalog/_show_default"
    end
    it "should not have an image tag" do
      expect(rendered).not_to have_selector("img")
    end
    it "should call the openseadragon picture tag" do
      expect(view).to have_received(:openseadragon_picture_tag).once
    end
  end

  def build_resource(medium: false, pyramidal: false)
    r = GenericAsset.new

    if medium
      r.workflow_metadata.medium_path = OregonDigital.derivative_injector.medium_path("test").to_s
    end

    if pyramidal
      r.workflow_metadata.pyramidal_path = OregonDigital.derivative_injector.pyramidal_path("test").to_s
    end

    r
  end
end
