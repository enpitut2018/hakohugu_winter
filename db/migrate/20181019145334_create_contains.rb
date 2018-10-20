class CreateContains < ActiveRecord::Migration[5.2]
  def change
    create_table :contains do |t|
      t.references :template, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
