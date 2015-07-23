class AddLabelToFacetFields < ActiveRecord::Migration
  def change
    add_column :facet_fields, :label, :string
  end
end
