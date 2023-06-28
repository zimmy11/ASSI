class ChangeColumnTypeInBans < ActiveRecord::Migration[7.0]
  def change
    remove_column :bans,:user_id
    add_belongs_to :bans,:user
    remove_column :bans,:admin_id
    add_reference :bans,:admin,foreign_key:{to_table: :users,column: :admin_id}
  end
end
