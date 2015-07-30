require "rails_helper"

RSpec.describe "Hydra Editor", :slow => true, :perform_enqueued => true do
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

  it "should save an external resource", :perform_enqueued => false do
    as_user(admin) do
      navigate_to_new_external_resource_path
      fill_in "external_asset_oembed", :with => "http://test.org"
      find(:css, "input.btn-primary").click
      expect(page).to have_content("successfully created")

      asset = ExternalAsset.last

      expect(asset.oembed).to eq ["http://test.org"]
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

  context "when a field is entered as a URI" do
    before do
      TriplePoweredResource.new("http://localhost:40/banana").tap do |t|
        t.preflabel = 'The Mighty Banana Said Unto Thee, "Behold My Yellowness"'
      end.persist!
    end

    it "should show the label when re-edited", :js => true do
      as_user(admin) do
        visit root_path
        navigate_to_new_image_path

        fill_in "image_title", :with => "John and Jane Doe, a portrait"
        fill_in "image_author", :with => "http://localhost:40/banana"
        button = find(:css, "input.btn-primary")
        button.click
        expect(page).to have_content("successfully created")

        pid = Image.last.id

        visit "/records/#{pid}/edit"

        input = all(:css, '.image_author input[type="text"].string:not(.hidden)')[0]
        expect(input.value).to eq('The Mighty Banana Said Unto Thee, "Behold My Yellowness"')
        expect(page).to have_selector(".switch-fields", :count => 1)
        find(".switch-fields").click
        input = all(:css, '.image_author input[type="text"].string:not(.hidden)')[0]
        expect(input.value).to eq "http://localhost:40/banana"
      end
    end

    it "should be read-only when re-edited" do
      as_user(admin) do
        navigate_to_new_image_path

        fill_in "image_title", :with => "John and Jane Doe, a portrait"
        fill_in "image_author", :with => "http://localhost:40/banana"
        button = find(:css, "input.btn-primary")
        button.click
        expect(page).to have_content("successfully created")

        pid = Image.last.id

        visit "/records/#{pid}/edit"

        input = all(:css, '.image_author input[type="text"].string')[0]
        expect(input[:readonly]).to eq('readonly')
      end
    end
  end

  def navigate_to_new_image_path
    visit "/records/new"
    page.select("Image", :from => "type")
    find(:css, "input.btn-primary").click
  end
  def navigate_to_new_external_resource_path
    visit "/records/new"
    page.select("External Asset", :from => "type")
    find(:css, "input.btn-primary").click
  end
end
