class AddForeignKeyEventUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users,:user_id,:username
    add_belongs_to :events,:organizer
    add_foreign_key :events, :users,column: :organizer_id

  end
end
