class CreateRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :saves do |t|
      t.string :user_id,null:false
      t.string :event_id,null:false
      t.timestamps
    end
    add_index :saves,[:user_id,:event_id],unique:true
    create_table :bans do |t|
      t.string :user_id,null:false
      t.string :event_id,null:false
      t.timestamps
    end
    create_table :org_events do |t|
      t.string :user_id,null:false
      t.string :event_id,null:false
      t.timestamps
    end
    create_table :presales do |t|
      t.string :user_id,null:false
      t.string :event_id,null:false
      t.timestamps
    end
    create_table :evaluations do |t|
      t.integer :value
      t.string :user_id,null:false
      t.string :event_id,null:false
      t.timestamps
    end
    add_index :bans,[:user_id,:event_id],unique:true
    add_index :org_events,[:user_id,:event_id],unique:true
    add_index :presales,[:user_id,:event_id],unique:true
    add_index :evaluations,[:user_id,:event_id],unique:true


  end
end
