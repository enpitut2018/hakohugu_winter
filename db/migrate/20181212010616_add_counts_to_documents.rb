class AddCountsToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :conversation_count, :integer, default: 0
  end
end
