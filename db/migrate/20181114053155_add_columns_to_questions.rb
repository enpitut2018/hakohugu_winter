class AddColumnsToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :qdetail, :text
    add_column :questions, :example, :text
  end
end
