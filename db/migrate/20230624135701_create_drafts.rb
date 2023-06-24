class CreateDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :drafts do |t|
      t.string :title
      t.integer :price
      t.string :date
      t.float :distance
      t.integer :limit
      t.string :planner

      t.timestamps
    end
  end
end
