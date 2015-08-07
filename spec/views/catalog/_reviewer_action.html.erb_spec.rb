require 'rails_helper'

RSpec.describe "catalog/_reviewer_action.html.erb" do
  let(:document) { instance_double(SolrDocument, :id => "1")}
  before do
    allow(view).to receive(:can?).with(:edit, document).and_return(permission_result)
    render :partial => "catalog/reviewer_action.html.erb", :locals => {:document => document }
  end
  
  context "when they can review the document" do
    let(:permission_result) { true }
    context "the document is ready for review" do
      let(:document) { instance_double(SolrDocument, :id => "1", :reviewed => false)}
      it "should have the review link" do
        expect(rendered).to have_link("Mark as Reviewed")
      end
    end
    context "the document is already reviewed" do
      let(:document) { instance_double(SolrDocument, :id => "1", :reviewed => true)}
      it "should not have the review link" do
        expect(rendered).not_to have_link("Mark as Reviewed")
      end
    end
  end
end
