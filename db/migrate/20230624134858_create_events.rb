class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.integer :price
      t.string :date
      t.float :distance
      t.integer :limit

      t.timestamps
    end
  end
end
