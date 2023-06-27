class RemoveFKeys < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key "bans", "users"
    remove_foreign_key "evaluations", "users"
    remove_foreign_key "presales", "users"
    remove_foreign_key "org_events", "users"
    remove_foreign_key "saves", "users"
    remove_reference "drafts", "users",index: true
    remove_foreign_key "bans", "users", column: "admin_id"

  end
end
