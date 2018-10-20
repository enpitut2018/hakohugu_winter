class RenameNameColumnToDocuments < ActiveRecord::Migration[5.2]
  def change
      rename_column :documents, :name, :title
  end
end
