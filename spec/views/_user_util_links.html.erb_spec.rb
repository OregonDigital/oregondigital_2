require 'rails_helper'

RSpec.describe "_user_util_links" do
  let(:blacklight_config) { CatalogController.new.blacklight_config }
  let(:ability) { Ability.new(user) }
  before do
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)
    allow(view).to receive(:has_user_authentication_provider?).and_return(true)
    allow(view).to receive(:current_user).and_return(user) if user
    allow(controller).to receive(:current_ability).and_return(ability)
    render
  end
  context "when not signed in" do
    let(:user) {nil}
    it "should not show the admin link" do
      expect(rendered).to_not have_link "Admin Panel", :href => admin_index_path
    end
  end
  context "when signed in as a user" do
    let(:user) { FactoryGirl.create(:user) }
    it "should not show the admin link" do
      expect(rendered).to_not have_link "Admin Panel", :href => admin_index_path
    end
  end
  context "when signed in as an admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }
    it "should show the admin link" do
      expect(rendered).to have_link "Admin Panel", :href => admin_index_path
    end
  end
end
