class CreateFacetFields < ActiveRecord::Migration
  def change
    create_table :facet_fields do |t|
      t.string :key

      t.timestamps null: false
    end
    add_index :facet_fields, :key, :unique => true
  end
end
