require "rails_helper"

RSpec.describe "Hydra Editor", :slow => true do
  let(:admin) {FactoryGirl.create(:user, :admin)}
  let(:file) { Rails.root.join("spec", "fixtures", "fixture_image.jpg") }

  it "should save an image" do
    as_user(admin) do
      navigate_to_new_image_path

      expect(page).to have_field("Content")
      attach_file("Content", file)
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
      image = Image.find(pid)
      expect(image.content.content).not_to be_blank
      expect(image.workflow_metadata.thumbnail_path).to include pid
      expect(image.workflow_metadata.thumbnail_path).not_to be_blank
      expect(image.workflow_metadata.medium_path).not_to be_blank
      expect(image.workflow_metadata.pyramidal_path).not_to be_blank
    end
  end
  it "should show invalid fields" do
    as_user(admin) do
      navigate_to_new_image_path

      fill_in "image_lcsubject", :with => "Not a URI"
      find(:css, "input.btn-primary").click
      
      expect(current_path).to eq "/records"
      expect(page).to have_content "contains a non-LCSH term"
    end
  end

  def navigate_to_new_image_path
    visit "/records/new"
    page.select("Image", :from => "type")
    find(:css, "input.btn-primary").click
  end
end
