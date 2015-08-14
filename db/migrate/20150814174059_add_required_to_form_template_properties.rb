class AddRequiredToFormTemplateProperties < ActiveRecord::Migration
  def change
    add_column :form_template_properties, :required, :boolean
  end
end
