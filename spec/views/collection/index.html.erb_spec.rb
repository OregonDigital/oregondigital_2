require 'rails_helper'

RSpec.describe "collection/index.html.erb" do
  context "when no set exists" do
    it "should display a no collections exist message" do
      render

      expect(rendered).to have_content "There are currently no collections."
    end
  end
  context "when sets exists" do
    it "should display their title" do
      assign(:collections, [create_collections])
      render

      expect(rendered).to have_content "Test Title"
    end
  end

end

def create_collections(title: "Test Title")
  GenericSet.create do |t|
    t.title = Array.wrap(title)
  end
end
