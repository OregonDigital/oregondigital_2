require 'rails_helper'

RSpec.describe "catalog/_show_image" do
  let(:document) { SolrDocument.new(resource.to_solr) }
  let(:resource) do
    GenericAsset.new do |g|
      g.workflow_metadata.medium_path = OregonDigital.derivative_injector.medium_path("test").to_s
    end
  end
  before do
    allow(view).to receive(:document).and_return(document)
    stub_template "catalog/_show_default" => "Default Stuff"
    render
  end
  it "should render default stuff" do
    expect(rendered).to have_content "Default Stuff"
    expect(response).to render_template "catalog/_show_default"
  end
  it "should have an image tag" do
    expect(rendered).to have_selector("img[src='/media/medium-images/t/s/test.jpg']")
  end
end
