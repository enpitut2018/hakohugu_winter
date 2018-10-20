class CreateAccessDocs < ActiveRecord::Migration[5.2]
  def change
    create_table :access_docs do |t|
      t.references :document, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
