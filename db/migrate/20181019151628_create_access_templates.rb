class CreateAccessTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :access_templates do |t|
      t.references :template, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
