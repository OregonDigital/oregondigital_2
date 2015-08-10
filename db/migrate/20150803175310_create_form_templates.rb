class CreateFormTemplates < ActiveRecord::Migration
  def change
    create_table :form_templates do |t|
      t.string :title, :null => false
    end

    create_table :form_template_properties do |t|
      t.references :form_template
      t.string :name, :null => false
      t.boolean :visible, :default => false
    end
  end
end
