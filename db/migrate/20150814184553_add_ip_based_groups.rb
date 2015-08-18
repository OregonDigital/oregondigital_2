class AddIpBasedGroups < ActiveRecord::Migration
  def change
    create_table(:ip_based_groups) do |t|
      t.string :title, :null => false
      t.integer :ip_start_i, :null => false, :limit => 8
      t.integer :ip_end_i, :null => false, :limit => 8
      t.references :role
    end
  end
end
