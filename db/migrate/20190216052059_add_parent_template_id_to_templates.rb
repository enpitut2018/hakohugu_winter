class AddParentTemplateIdToTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :templates, :parent_template_id, :integer
  end
end
