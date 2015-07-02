require 'rails_helper'

RSpec.describe "admin/facets/index.html.erb" do
  let(:facade) { FacetConfigurationFacade.new }
  context "when there are assets and facets" do
    let(:facet) { FacetField.create(:key => "title") }
    before do
      create_asset
      facet
      assign(:facets, facade)
      render
    end

    it "should have a destroy button for the existing facet field" do
      expect(rendered).to have_link "Delete", :href => admin_facet_path(:id => facet.id)
    end
    it "should have a create button" do
      expect(rendered).to have_button "Enable Alternative Facet"
    end
    it "should show top terms" do
      expect(rendered).to have_content "Alphabet Soup"
      expect(rendered).to have_content "Invasion of the Bananas"
    end

    def create_asset
      asset_document = GenericAsset.new do |c|
        c.title = ["Alphabet Soup"]
        c.alternative = ["Invasion of the Bananas"]
      end.to_solr.merge({"id" => "s9as9z"})
      ActiveFedora.solr.conn.add asset_document
      ActiveFedora.solr.conn.commit
    end
  end
end
