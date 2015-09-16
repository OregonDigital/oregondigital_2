class CreateFacetItems < ActiveRecord::Migration
  def change
    create_table :facet_items do |t|
      t.string :value
      t.boolean :visible, :default => true

      t.timestamps null: false
    end
    add_index :facet_items, :value, unique: true
  end
end
