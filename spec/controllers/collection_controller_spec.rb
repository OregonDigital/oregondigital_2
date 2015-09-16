require 'rails_helper'

RSpec.describe CollectionController do
  describe "#index" do
    context "when the set exists" do
      it "should set the collections" do
        collections = create_collections
        get :index

        expect(assigns(:collections)).to eq [collections]
        expect(response).to render_template "collection/index"
      end
    end
  end
end

def create_collections(title: "Test Set")
  GenericSet.create do |t|
    t.title = Array.wrap(title)
  end
end
