class AddTemplateIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :template, foreign_key: true
  end
end
