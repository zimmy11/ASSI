class AddKeys < ActiveRecord::Migration[7.0]
  def change
    rename_column :saves,:events_id,:event_id
    rename_column :saves,:users_id,:user_id
    rename_column :org_events,:events_id,:event_id
    rename_column :org_events,:users_id,:user_id
    rename_column :presales,:events_id,:event_id
    rename_column :presales,:users_id,:user_id
    rename_column :evaluations,:events_id,:event_id
    rename_column :evaluations,:users_id,:user_id
    rename_column :bans,:users_id,:user_id
    add_foreign_key :saves,:events
    add_foreign_key :saves,:users
    add_foreign_key :org_events,:events
    add_foreign_key :org_events,:users
    add_foreign_key :presales,:events
    add_foreign_key :presales,:users
    add_foreign_key :evaluations,:events
    add_foreign_key :evaluations,:users
    add_foreign_key :bans,:users,column: :admin_id
    add_foreign_key :bans,:users
  end
end
