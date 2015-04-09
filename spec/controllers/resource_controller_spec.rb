require 'rails_helper'

RSpec.describe ResourceController  do
  describe '#show' do
    it "should raise an error if there is no resource" do
      expect{ get :show, :id => 'id' }.to raise_error ActionController::RoutingError
    end
    it "should redirect to a catalog resource if a resource exists" do
      allow(ActiveFedora::Base).to receive(:exists?).with('id').and_return(true)
      expect( get :show, :id => 'id').to redirect_to '/catalog/id'
    end
  end
end

