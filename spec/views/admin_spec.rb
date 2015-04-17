require 'rails_helper'
require 'spec_helper'

RSpec.describe "admin/index.html.erb" do
  describe "when visiting the admin panel" do
    context "when on the admin panel" do
      before do
        allow(view).to receive(:has_search_parameters?).and_return(false)
        allow(view).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
      end
      it "should display the admin panel" do
        render
        expect(rendered).to 
      end
    end
  end
end
