class CollectionController < ApplicationController

  def index
    @collections = find_all_collections
  end

  private

  def find_all_collections
    GenericSet.all
  end
end
