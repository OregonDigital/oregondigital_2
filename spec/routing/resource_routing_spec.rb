require 'rails_helper'

RSpec.describe 'resource routing' do
  it 'routes /resource/id to the resource controller' do
    expect(get("/resource/id")).to route_to("resource#show", :id => "id")
  end
end


