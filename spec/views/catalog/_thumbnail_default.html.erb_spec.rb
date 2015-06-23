require 'rails_helper'

RSpec.describe "catalog/_thumbnail_default.html.erb" do
  let(:document) { SolrDocument.new(solr_hash) }
  let(:solr_hash) {
    {
      :id => "1",
      :workflow_metadata__thumbnail_path_ssim => [OregonDigital.derivative_injector.thumbnail_path("13")]
    }
  }
  let(:blacklight_config) {
    BlacklightConfig.new(GenericAsset, CatalogController.blacklight_config).configuration
  }
  describe "thumbnails" do
    before do
      allow(view).to receive(:blacklight_config).and_return(blacklight_config)
      allow(view).to receive(:render_grouped_response?).and_return false
      allow(view).to receive(:current_search_session).and_return nil
      allow(view).to receive(:search_session).and_return({})
      assign :response, double(start: 0)
      render :partial => "catalog/thumbnail_default", :locals => {:document => document, :document_counter => 1}
    end
    context "when there's a thumbnail" do
      it "should show it" do
        expect(rendered).to have_selector "img[src='/media/thumbnails/3/1/13.jpg']"
      end
    end
    context "when there's no thumbnail" do
      let(:solr_hash) { {:id => 1} }
      it "should not show anything" do
        expect(rendered).not_to have_selector "img"
      end
    end
  end
end
