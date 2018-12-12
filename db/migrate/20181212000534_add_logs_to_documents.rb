class AddLogsToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :conversation_logs, :json
    add_column :documents, :question_number, :integer, default: 0
  end
end
