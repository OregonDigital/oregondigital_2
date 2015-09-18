require 'rails_helper'

RSpec.describe "collection routing" do
  it "should route /sets to collection#index" do
    expect(get '/sets').to route_to :controller => "collection", :action => "index"
  end
end
