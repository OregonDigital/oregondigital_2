require 'rails_helper'

RSpec.describe "facet admin routing" do
  it "should route /admin/facets to facets#index" do
    expect(get '/admin/facets').to route_to :controller => "admin/facets", :action => "index"
  end
  it "should route post /admin/facets to facets#create" do
    expect(post '/admin/facets').to route_to :controller => "admin/facets", :action => "create"
  end
  it "should route delete /admin/facet/1 to facets#destroy" do
    expect(delete '/admin/facets/1').to route_to :controller => "admin/facets", :action => "destroy", :id => "1"
  end
end
