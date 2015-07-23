class FacetField < ActiveRecord::Base
  validates :key, :presence => true

  def view_label
    if label.present?
      label
    else
      key.titleize
    end
  end
end
