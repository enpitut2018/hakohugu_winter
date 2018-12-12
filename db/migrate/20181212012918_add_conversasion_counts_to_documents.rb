class AddConversasionCountsToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :count_t, :integer, default: 0
    add_column :documents, :count_d, :integer, default: 0
    add_column :documents, :count_e, :integer, default: 0
  end
end
