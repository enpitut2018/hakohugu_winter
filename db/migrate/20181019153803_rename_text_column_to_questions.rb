class RenameTextColumnToQuestions < ActiveRecord::Migration[5.2]
  def change
      rename_column :questions, :text, :qtext
  end
end
