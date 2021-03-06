class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :template_id, null: false

      t.timestamps

      t.index :user_id
      t.index :template_id
      t.index [:user_id, :template_id], unique: true
    end
  end
end
