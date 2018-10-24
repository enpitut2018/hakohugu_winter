class ChangeDatatypeQtextOfQuestions < ActiveRecord::Migration[5.2]
  def change
      change_column :questions, :qtext, :text
  end
end
