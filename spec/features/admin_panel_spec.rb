require 'rails_helper'
require 'spec_helper'

RSpec.describe "admin panel" do
  context "when not logged in as an admin" do
    before do
      visit root_path
    end
    it "should not display the admin link" do
      #expect(page).to_not have_link("Admin Panel")
    end
  end
  context "when logged in as an admin" do
    before do
      visit root_path
      #create admin user
      #log in as admin user
    end
    it "should display the admin link" do
      expect(page).to have_link("Admin Panel")
    end
    context "when on the admin panel" do
      before do
        #click_link "Admin Panel"
      end
      it "should display the admin panel" do
        #expect(page).to have_content("Admin Panel")
      end
    end
  end
end
