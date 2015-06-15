require 'rails_helper'

RSpec.describe "catalog/_show_default.html.erb" do
  let(:resource) do
    GenericAsset.new do |g|
      g.attributes = {
        :title => ["Title"],
        :alternative => ["Test"],
        :date => ["06/17/2015"],
        :creator => ["Brandon"],
        :material => []
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
  it "should show all other fields" do
    expect(rendered).to have_content("Date")
    expect(rendered).to have_content("06/17/2015")
    expect(rendered).to have_content("Creator")
    expect(rendered).to have_content("Brandon")
  end
  it "should not show blank fields" do
    expect(rendered).to_not have_content("Material")
    expect(rendered).to_not have_content("Space Smores")
  end
end
