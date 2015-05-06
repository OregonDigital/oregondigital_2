require 'rails_helper'

RSpec.describe 'admin/index' do
  let(:ability) { Ability.new(user) }
  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    render
  end
  context "when logged in as an admin" do
    let(:user) { FactoryGirl.build(:user, :admin) }
    it "should display the admin panel" do
      expect(rendered).to have_content "Admin Panel"
    end
    context "when ingesting a new record" do
      it "should have a link to ingest a new record" do
        expect(rendered).to have_link "Ingest a New Record", :href => hydra_editor.new_record_path
        expect(rendered).to have_link "Edit User Roles", :href => role_management.roles_path
     end
    end
  end
end
