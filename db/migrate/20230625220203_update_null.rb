class UpdateNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bans, :user_id,true
    change_column_null :bans, :admin_id,true
    change_column_null :presales, :user_id,true
    change_column_null :presales, :event_id,true
    change_column_null :saves, :user_id,true
    change_column_null :saves, :event_id,true
    change_column_null :org_events, :user_id,true
    change_column_null :org_events, :event_id,true
    change_column_null :evaluations, :user_id,true
    change_column_null :evaluations, :event_id,true
    change_column_null :drafts, :title,true
    change_column_null :events, :date,true
    change_column_null :events, :title,true
    change_column_null :events, :price,true
    change_column_null :events, :location,true
    change_column_null :users, :user_id,true
    change_column_null :users, :password,true
    change_column_null :users, :email,true
    change_column_null :users, :role,true
    remove_index :bans ,column: [:user_id,:admin_id]
    remove_index :drafts ,column: [:title,:date]
    remove_index :evaluations ,column: [:user_id,:event_id]
    remove_index :events ,:title
    remove_index :org_events ,column: [:user_id,:event_id]
    remove_index :presales ,column: [:user_id,:event_id]
    remove_index :saves ,column: [:user_id,:event_id]
    remove_index :users ,:user_id



  end
end
