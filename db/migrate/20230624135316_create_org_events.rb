class CreateOrgEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :org_events do |t|
      t.string :event
      t.string :user

      t.timestamps
    end
  end
end
