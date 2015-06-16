require 'rails_helper'

RSpec.describe "sets/_home_text.html.erb_spec.rb" do
  before do
    assign(:set, build_set)
    render :partial => "sets/home_text"
  end
  it "should display the title" do
    expect(rendered).to have_content("Test Title")
  end
  it "should display the description" do
    expect(rendered).to have_content("This is a test set")
  end
  it "should not have array brackets" do
    expect(rendered).not_to have_content '["Test Title"]'
    expect(rendered).not_to have_content '["This is a test set"]'
  end

  def build_set(title: "Test Title", description: "This is a test set")
    c = object_double(GenericSet.new)
    allow(c).to receive(:title).and_return([title])
    allow(c).to receive(:description).and_return([description])
    c
  end
end
