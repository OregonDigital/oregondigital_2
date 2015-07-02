require 'rails_helper'

RSpec.describe "facet admin routing" do
  it "should route /admin/facets to facets#index" do
    expect(get '/admin/facets').to route_to :controller => "admin/facets", :action => "index"
  end
end
