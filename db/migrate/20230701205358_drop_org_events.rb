class DropOrgEvents < ActiveRecord::Migration[7.0]
  def change
    drop_table :org_events
  end
end
