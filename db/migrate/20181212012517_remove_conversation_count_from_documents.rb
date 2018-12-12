class RemoveConversationCountFromDocuments < ActiveRecord::Migration[5.2]
  def change
    remove_column :documents, :conversation_count, :integer
  end
end
