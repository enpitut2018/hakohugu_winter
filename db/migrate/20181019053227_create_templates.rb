class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.integer :scope

      t.timestamps
    end
  end
end
