require 'rails_helper'

RSpec.describe "catalog/_show_default.html.erb" do
  let(:resource) do
    GenericAsset.new do |g|
      g.attributes = {
        :title => ["Title"],
        :alternative => ["Test"],
      }
    end
  end

  let(:file) { File.open(File.join(fixture_path, 'fixture_image.jpg'), 'rb') }
  let(:blacklight_config) {
    BlacklightConfig.new(GenericAsset, CatalogController.blacklight_config).configuration
  }
  let(:document) { SolrDocument.new(resource.to_solr) }
  before do
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)

    render :partial => "catalog/show_default.html.erb", :locals => {:document => document }
  end
  it "should show the title" do
    expect(rendered).to have_content "Title"
  end
  it "should show alternative" do
    expect(rendered).to have_content("Alternative")
    expect(rendered).to have_content("Test")
  end

  describe "catalog/_small_image_viewer" do
    context "when an image with jpeg content" do

      before do 
        resource.add_file(file, :path => "content")
      end
      it "should have a basic image tag" do
        expect(response).to render_template(:partial => '_small_image_viewer')
        expect(rendered).to have_selector("#small-image-viewer")
        # expect(rendered).to have_selector("img")
      end

    end
  end
end
