require 'rails_helper'

RSpec.describe "catalog/_edit_action.html.erb" do
  let(:resource) do
    GenericAsset.new do |g|
      g.attributes = {
        :id => 1,
        :title => ["Title"],
        :alternative => ["Test"]
      }
    end
  end
  let(:blacklight_config) {
    BlacklightConfig.new(GenericAsset, CatalogController.blacklight_config).configuration
  }
  let(:document) { SolrDocument.new(resource.to_solr) }
  let(:ability) { Ability.new(user) }
  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)
    render :partial => "catalog/edit_action.html.erb", :locals => {:document => document }
  end
  context "when not logged in" do
    let(:user) { nil }
    it "should not have edit link" do
      expect(rendered).to_not have_link("Edit")
    end
  end
  context "when logged in as a user" do
    let(:user) { FactoryGirl.create(:user) }
    it "should not have edit link" do
      expect(rendered).to_not have_link("Edit")
    end
  end
  context "when logged in as an admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }
    it "should have a link to edit" do
      expect(rendered).to have_content("Edit")
    end
  end
end
