class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.integer :distanza
      t.string :titolo
      t.integer :prezzo
      t.string :data

      t.timestamps
    end
  end
end
