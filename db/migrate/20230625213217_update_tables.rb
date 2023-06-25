class UpdateTables < ActiveRecord::Migration[7.0]
  def change
    change_column :users,:role,:string,null:false
    rename_column :saves,:user_id,:users_id
    rename_column :saves,:event_id,:events_id
    rename_column :bans,:user_id,:users_id
    rename_column :bans,:event_id,:admin_id
    rename_column :org_events,:user_id,:users_id
    rename_column :org_events,:event_id,:events_id
    rename_column :presales,:user_id,:users_id
    rename_column :presales,:event_id,:events_id
    rename_column :evaluations,:user_id,:users_id
    rename_column :evaluations,:event_id,:events_id

  end
end
