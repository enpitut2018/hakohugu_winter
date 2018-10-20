class RenameNameColumnToTemplates < ActiveRecord::Migration[5.2]
  def change
      rename_column :templates, :name, :title
  end
end
