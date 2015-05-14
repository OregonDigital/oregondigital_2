require 'rails_helper'

RSpec.describe "records/_form" do
  let(:form) do
    ImageForm.new(resource)
  end

  let(:resource) do
    Image.new
  end
  let(:params) do
    {
      :type => "Image"
    }
  end
  before do
    allow(view).to receive(:params).and_return(params)
    render :partial => "form", :locals => {:form => form}
  end
  it "should have a named file field" do
    expect(rendered).to have_selector "input[type=file][name='image[content]']"
  end
end
