class AddDefaultToDocumentScope < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:documents, :scope, 0)
  end
end
