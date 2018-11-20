class AddTopicToTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :templates, :topic, :string
  end
end
