require 'rails_helper'

RSpec.describe "records/_form" do
  let(:form) do
    ImageForm.new(resource)
  end

  let(:resource) do
    Reviewable.new(ValidatedAssetRepository.new(Image).new)
  end

  let(:params) do
    {
      :type => "Image"
    }
  end

  before do
    allow(view).to receive(:params).and_return(params)
  end

  it "should have a named file field" do
    render :partial => "form", :locals => {:form => form}
    expect(rendered).to have_selector "input[type=file][name='image[content]']"
  end

  it "should have the hint show up" do
    render :partial => "form", :locals => {:form => form}
    expect(rendered).to have_css ".help-block"
  end

  context "When there's no content" do
    it "shouldn't say anything" do
      render :partial => "form", :locals => {:form => form}
      expect(rendered).not_to have_content("already has a file")
    end
  end

  context "When content is already present" do
    it "should let the user know" do
      allow(form).to receive(:has_content?).and_return(true)
      render :partial => "form", :locals => {:form => form}
      expect(rendered).to have_content("already has a file")
    end
  end

  context "When a new record is present" do
    before do
      allow(resource).to receive(:new_record?).and_return(false)
    end
    it "should not display the check box" do
      render :partial => "form", :locals => {:form => form} 
      expect(rendered).to_not have_content("Mark this as needing review.")
    end
  end
  context "When an already saved record is present" do
    before do
      allow(resource).to receive(:new_record?).and_return(false)
    end
    it "should display the check box" do
      render :partial => "form", :locals => {:form => form} 
      expect(rendered).to have_content("Mark this as needing review.")
    end
  end 

  context "when there are hidden terms" do
    it "should put them under a hidden field" do
      allow(form).to receive(:hidden_terms).and_return([:title])

      render :partial => "form", :locals => {:form => form}

      expect(rendered).to have_selector "#hidden-fields input[name='image[title][]']" 
    end
  end
  context "when there are no hidden terms" do
    it "should not display the hidden button" do
      render :partial => "form", :locals => {:form => form}

      expect(rendered).not_to have_selector "*[data-toggle-field=hidden-fields]"
      expect(rendered).not_to have_content "Show Hidden Fields"
    end
  end
end
