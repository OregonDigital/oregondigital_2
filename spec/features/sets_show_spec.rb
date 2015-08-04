require 'rails_helper'

RSpec.describe "Sets show page", :slow => true do
  it "should be able to display an asset" do
    set = GenericSet.create(:read_groups => ["public"])
    asset = GenericAsset.create(:title => ["Test Title"], :read_groups => ["public"], :set => [set])

    visit sets_path(:id => asset.id, :set_id => set.id)

    expect(page).to have_content(asset.title.first)
  end
end
