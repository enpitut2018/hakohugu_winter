class AddCountsHToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :sum_h, :integer, default: 0
    add_column :documents, :count_called_h, :integer, default: 0
  end
end
