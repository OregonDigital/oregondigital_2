require 'rails_helper'

RSpec.describe SetsController do
  describe "#index" do
    context "when the set doesn't exist" do
      it "set flash" do
        visit_set_index(set: double("set", id: "BadID"))
        
        expect(response).not_to be_success
        expect(flash[:error]).to eq I18n.t("sets.set_not_found")
        expect(response).to redirect_to root_path
      end
    end
    context "when the set exists" do
      it "should set it" do
        set = create_set

        visit_set_index(set: set)

        expect(assigns(:set)).to eq set
        expect(response).to render_template "catalog/index"
      end
    end
    context "when there are items not in the set" do
      it "should not return them" do
        set = create_set
        create_item(set: "Not Right")

        visit_set_search_results(set: set)
        
        records = assigns[:document_list]
        expect(records).to be_empty
      end
    end
    context "when there are items in the set" do
      it "should return them" do
        set = create_set
        item = create_item(set: set)

        visit_set_search_results(set: set)

        records = assigns[:document_list]
        expect(records.first.id).to eq item.id
      end
    end
  end

  describe "#blacklight_config" do
    it "should have a set configured" do
      set = instance_double(GenericSet, :id => "test")
      allow(GenericSet).to receive(:load_instance_from_solr).and_return(
        set
      )
      # Set expectation.
      expect_any_instance_of(BlacklightConfig).to receive(:set=).with(set).and_call_original
      visit_set_index(set: set)
    end
  end

  def visit_set_index(set:)
    get :index, :set_id => set.id
  end

  def visit_set_search_results(set:)
    get :index, :set_id => set.id, :search_field => "all_fields"
  end

  def create_set(title: "Test Set", description: "Test Description")
    GenericSet.create do |t|
      t.title = Array.wrap(title)
      t.description = Array.wrap(description)
    end
  end

  def create_item(set:)
    GenericAsset.create do |t|
      t.set = [set]
      t.read_groups = ["public"]
    end
  end
end
