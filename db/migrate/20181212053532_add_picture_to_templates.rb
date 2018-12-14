class AddPictureToTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :templates, :picture, :string
  end
end
