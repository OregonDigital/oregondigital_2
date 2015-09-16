require 'rails_helper'

RSpec.describe "all sets routing" do
  it "should route /sets to sets#index" do
    expect(get '/sets').to route_to :controller => "sets", :action => "index"
  end
end
