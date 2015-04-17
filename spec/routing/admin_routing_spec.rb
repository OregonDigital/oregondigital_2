require 'rails_helper'

RSpec.describe "admin routing" do
  it "should route /admin to admin#index" do
    expect(get '/admin').to route_to :controller => "admin", :action => "index"
  end
end
