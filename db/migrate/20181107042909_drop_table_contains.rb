class DropTableContains < ActiveRecord::Migration[5.2]
  def change
      drop_table :contains
  end
end
