class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :template, foreign_key: true
      t.integer :scope

      t.timestamps
    end
  end
end
