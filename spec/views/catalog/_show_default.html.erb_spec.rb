require 'rails_helper'

RSpec.describe "catalog/_show_default.html.erb" do
  let(:resource) do
    GenericAsset.new do |g|
      g.attributes = attributes_list 
    end
  end
  let(:attributes_list) {{ :title => ["Title"], :alternative => ["Test"] }}
  let(:attributes_list_with_uri) {attributes_list.merge!({:lcsubject => value_with_uri})} 
  let(:attributes_list_with_both) {attributes_list.merge!({:lcsubject => both_uri_and_non_uri})} 
  let(:value_with_uri) {["http://www.nothingissomething.com"]}
  let(:both_uri_and_non_uri) {["Some useful information", "http://www.uri.com"]}
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
  context "When a field has a uri in it" do
    let(:resource) do
      GenericAsset.new do |g|
        g.attributes = attributes_list_with_uri
      end 
    end
    it "should display the fields that dont have uri's in them" do
      expect(rendered).to have_content("Alternative")
      expect(rendered).to_not have_content("Lcsubject")
    end
  end
  context "When a field has a uri and non uri in it" do
    let(:resource) do
      GenericAsset.new do |g|
        g.attributes = attributes_list_with_both
      end 
    end
    it "should display the fields that dont have uri's in them" do
      expect(rendered).to have_content("Alternative")
      expect(rendered).to have_content("Lcsubject")
      expect(rendered).to_not have_content("http://www.uri.com")
    end
  end
 
end
