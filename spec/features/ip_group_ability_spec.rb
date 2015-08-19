require "rails_helper"

RSpec.describe "IP-based Groups", :slow => true do
  let(:admin_panel_link) { "Admin Panel" }
  let(:create_text) { "Create a New Record" }
  let(:auth_text) { "You are not authorized" }
  before do
    create_group("admin", "127.0.0.1/24")
    allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return(ip)
  end

  describe "Management" do
    let(:ip) { "127.0.0.23" }
    it "should allow an admin to do stuff" do
      visit root_path
      click_link admin_panel_link
      click_link "Manage IP-based Roles"
      click_link "Create New IP Group"
      fill_in "Title", :with => "test title"
      fill_in "Ip start", :with => "192.168.0.0"
      fill_in "Ip end", :with => "192.168.255.255"
      select "admin", :from => "Role"
      click_button "Save IP Group"

      expect(page).to have_content("Created new IP Group")
      expect(page).to have_content("192.168.0.0")
      expect(page).to have_content("192.168.255.255")
      click_link "Edit test title"
      click_button "Save IP Group"
      expect(page).to have_content("IP Group updated")

      click_link "Delete test title"
      expect(page).to have_content("IP Group deleted")
      expect(page).not_to have_content("192.168.0.0")
      expect(page).not_to have_content("192.168.255.255")
    end
  end

  context "when a user's IP address sets admin" do
    let(:ip) { "127.0.0.23" }
    it "should show the admin panel" do
      visit root_path
      expect(page).to have_link(admin_panel_link)
    end

    it "should allow the user to visit the ingest page" do
      visit ingest_options_path
      expect(page).to have_content(create_text)
      expect(page).not_to have_content(auth_text)
    end
  end

  context "when a user's IP address doesn't set any groups" do
    let(:ip) { "183.7.34.90" }
    it "should not show the admin panel" do
      visit root_path
      expect(page).not_to have_link(admin_panel_link)
    end

    it "shouldn't allow the user to visit the ingest page" do
      visit ingest_options_path
      expect(page).not_to have_content(create_text)
      expect(page).to have_content(auth_text)
    end
  end
end

def create_group(name, range)
  cidr = NetAddr::CIDR.create(range)
  group = FactoryGirl.build(:ip_based_group, :role_name => name)
  group.ip_start_i = cidr.first(:Objectify => true).to_i
  group.ip_end_i = cidr.last(:Objectify => true).to_i
  group.save!
  group
end
