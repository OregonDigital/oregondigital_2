require 'rails_helper'

RSpec.describe ResourceController  do
  describe '#show' do
    it "should raise an error if there is no resource" do
      expect{ get :show, :id => 'id' }.to raise_error ActionController::RoutingError
    end
  end
end

