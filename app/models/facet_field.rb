class FacetField < ActiveRecord::Base
  validates :key, :presence => true
end
