require 'rails_helper'

RSpec.describe "catalog/_show_default.html.erb" do
  let(:resource) do
    GenericAsset.new do |g|
      g.attributes = {
        :title => ["Title"],
        :alternative => ["Test"]
      }
    end
  end
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
end
