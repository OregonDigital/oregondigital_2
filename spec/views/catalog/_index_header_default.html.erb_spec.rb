require 'rails_helper'

RSpec.describe "catalog/_index_header_default" do
  let :document do
    SolrDocument.new :id => 'xyz', :format => 'a'
  end

  let :blacklight_config do
    BlacklightConfig.new(GenericAsset, CatalogController.blacklight_config).tap do |c|
      c.set = set
    end.configuration
  end
  
  let(:set) do
    instance_double(GenericSet, :id => "myset")
  end

  before do
    assign :response, double(start: 0)
    allow(view).to receive(:render_grouped_response?).and_return false
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)
    allow(view).to receive(:current_search_session).and_return nil
    allow(view).to receive(:search_session).and_return({})
    allow(view).to receive(:render_index_doc_actions)
    assign(:set, set)
    render :partial => "catalog/index_header_default", :locals => {:document => document, :document_counter => 1}
  end
  it "should display a link, but stay in the sets path" do
    expect(rendered).to have_link document.id, :href => sets_path(:id => document.id, :set_id => set.id)
  end
end
