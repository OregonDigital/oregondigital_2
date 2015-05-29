require 'rails_helper'

RSpec.describe "catalog/_edit_action.html.erb" do
  let(:document) { instance_double(SolrDocument, :id => "1")}
  before do
    allow(view).to receive(:can?).with(:edit, document).and_return(permission_result)
    render :partial => "catalog/edit_action.html.erb", :locals => {:document => document }
  end
  context "when they can edit the document" do
    let(:permission_result) { true }
    it "should have the edit link" do
      expect(rendered).to have_link("Edit")
    end
  end
  context "when they can't edit the document" do
    let(:permission_result) { false }
    it "should not have the edit link" do
      expect(rendered).not_to have_link "Edit"
    end
  end
end
