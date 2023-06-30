class AddLastForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :drafts,:users
    add_foreign_key :bans,:users
    add_foreign_key :saves,:users
    add_foreign_key :org_events,:users
    add_foreign_key :presales,:users
    add_foreign_key :evaluations,:users


  end
end
