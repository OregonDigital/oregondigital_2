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
  it "should route /admin/facets/1/remove_item to admin/facets#remove_item" do
    expect(get '/admin/facets/1/remove_item').to route_to :controller => "admin/facets", :action  => "remove_item", :id=> "1"
  end
  it "should route /admin/facets/1/add_item to admin/facets#add_item" do
    expect(get '/admin/facets/1/add_item').to route_to :controller => "admin/facets", :action  => "add_item", :id=> "1"
  end

end
