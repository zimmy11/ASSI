class CreateRelationsUserEvents < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key "evaluations", "events"
    remove_foreign_key "org_events", "events"
    remove_foreign_key "presales", "events"
    remove_foreign_key "saves", "events"
    drop_table :org_events
    drop_table :saves
    drop_table :presales
    drop_table :evaluations
    create_table :org_events do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.timestamps
    end
    create_table :saves do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.timestamps
    end
    create_table :presales do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.timestamps
    end
    create_table :evaluations do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.integer :value
      t.timestamps
    end
    add_foreign_key "evaluations", "events"
    add_foreign_key "org_events", "events"
    add_foreign_key "presales", "events"
    add_foreign_key "saves", "events"
  end
end
