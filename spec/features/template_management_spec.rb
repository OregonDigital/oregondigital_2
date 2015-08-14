require "rails_helper"

RSpec.describe "Template Management", :slow => true do
  let(:admin) {FactoryGirl.create(:user, :admin)}

  before do
    as_user admin
    navigate_to_template_admin_path
  end

  it "should show all the terms" do
    click_link "Create New Template"
    checkboxes = checkbox_states
    expect(checkboxes.length).to eq(GenericAssetForm.terms.length)
    GenericAssetForm.terms.each do |t|
      expect(checkboxes[t]).not_to be_checked
    end
  end

  context "when visiting the new template form" do
    before do
      click_link "Create New Template"
    end

    context "when saving a new template" do
      let(:template_name) { "Test template %d" % Random.rand(99999) }
      let(:check_fields) { [:title, :view, :subject] }
      let(:caption) { "Available Templates" }

      before do
        fill_in "form_template_title", :with => template_name
        check_fields.each {|field| show_field field}
        click_button "Save Template"
      end

      it "should succeed" do
        expect(page).to have_content("Created new template")
      end

      it "should show the template in the list" do
        expect(page).to have_content(caption)
        expect(page).to have_link(template_name)
      end

      context "when editing the template" do
        before do
          click_link "Edit " + template_name
        end

        it "should have persisted all fields" do
          checkboxes = checkbox_states
          check_fields.each {|field| expect(checkboxes[field]).to be_checked}
          (GenericAssetForm.terms - check_fields).each do |t|
            expect(checkboxes[t]).not_to be_checked
          end
        end

        context "when submitting changes" do
          let(:updated_template_name) { "Updated test template %d" % Random.rand(99999) }
          before do
            fill_in "form_template_title", :with => updated_template_name
            show_field "creator"
            hide_field "title"
            click_button "Save Template"
          end

          it "should succeed" do
            expect(page).to have_content("Template updated")
          end

          it "should show the template in the list" do
            expect(page).to have_link(updated_template_name)
          end
        end
      end

      context "when deleting the template" do
        before do
          click_link "Delete " + template_name
        end

        it "should succeed" do
          expect(page).to have_content("Template deleted")
        end

        it "should remove the template from the list" do
          # We should have deleted the only template, so the whole table will
          # be gone
          expect(page).not_to have_content(caption)
        end
      end
    end
  end
end

def navigate_to_template_admin_path
  visit root_path
  click_link "Admin Panel"
  click_link "Manage Ingest Templates"
end

def checkbox_states
  checkboxes = HashWithIndifferentAccess.new
  all('.template-property').each do |el|
    checkboxes[el.find(".panel-title").text] = el.find("input[type=checkbox]")
  end

  checkboxes
end

def show_field(field)
  within "##{field}" do
    check "Show"
  end
end

def hide_field(field)
  within "##{field}" do
    uncheck "Show"
  end
end

