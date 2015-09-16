class FacetItem < ActiveRecord::Base
  validates :value, :presence => true
end
