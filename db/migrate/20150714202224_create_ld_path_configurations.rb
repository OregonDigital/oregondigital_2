class CreateLdPathConfigurations < ActiveRecord::Migration
  def change
    create_table :ld_path_configurations do |t|
      t.string :name
      t.text :path
      t.text :description

      t.timestamps null: false
    end
  end
end
