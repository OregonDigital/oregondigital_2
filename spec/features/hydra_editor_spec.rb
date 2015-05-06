require "rails_helper"

RSpec.describe "Hydra Editor", :slow => true do
  let(:admin) {FactoryGirl.create(:user, :admin)}

  it "should save an image" do
    as_user(admin) do
      visit "/records/new"
      page.select("Image", :from => "type")
      find(:css, "input.btn-primary").click

      fill_in "image_title", :with => "John and Jane Doe, a portrait"
      fill_in "image_description", :with => "This image depicts the most well-known corpse couple, the Does"
      find(:css, "input.btn-primary").click
      expect(page).to have_content("successfully created")

      pid = Image.last.id

      # Edit twice to verify we aren't breaking metadata on the first edit
      visit "/records/#{pid}/edit"
      find(:css, "input.btn-primary").click
      visit "/records/#{pid}/edit"
      find(:css, "input.btn-primary").click

      expect(page).to have_content("John and Jane Doe, a portrait")
      expect(page).to have_content("This image depicts the most well-known corpse couple, the Does")
      expect(page).to have_content("successfully updated")
    end
  end
end
