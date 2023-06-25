class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title,null:false,unique:true
      t.integer :price,null:false
      t.string  :date,null:false
      t.integer :limit
      t.string  :location,null:false
      t.timestamps
    end
    create_table :users do |t|
      t.string :user_id,null:false,unique:true
      t.string :password,null:false
      t.string  :email,null:false
      t.string :role,null:false
      t.timestamps
    end
    create_table :drafts do |t|
      t.string :title,null:false
      t.integer :price
      t.string  :date
      t.integer :limit
      t.string  :location
      t.timestamps
    end
    add_index :drafts,[:title,:date],unique:true
  end
end
