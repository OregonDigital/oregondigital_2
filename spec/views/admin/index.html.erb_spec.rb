require 'rails_helper'

RSpec.describe 'admin/index' do
  let(:ability) { Ability.new(user) }
  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    render
  end
  context "when not logged in" do
    let(:user) {nil}
    it "should display an insufficient permissions error" do
      expect(rendered).to_not have_content "Admin Panel"
      expect(rendered).to have_content "You do not have sufficient permissions to access this page."
    end
  end
  context "when logged in as a user" do
    let(:user) { FactoryGirl.build(:user) }
    it "should display an insufficient permissions error" do
      expect(rendered).to_not have_content "Admin Panel"
      expect(rendered).to have_content "You do not have sufficient permissions to access this page."
    end
  end
  context "when logged in as an admin" do
    let(:user) { FactoryGirl.build(:admin) }
    it "should display the admin panel" do
      expect(rendered).to have_content "Admin Panel"
    end
    context "when ingesting a new record" do
      it "should have a link to injest a new record" do
        expect(rendered).to have_link "Ingest a New Record", :href => hydra_editor.new_record_path
     end
    end
  end
end
