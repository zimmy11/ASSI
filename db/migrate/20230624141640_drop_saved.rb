class DropSaved < ActiveRecord::Migration[7.0]
  def change
    drop_table :saveds 
    drop_table :events
  end
end
