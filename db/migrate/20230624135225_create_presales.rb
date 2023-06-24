class CreatePresales < ActiveRecord::Migration[7.0]
  def change
    create_table :presales do |t|
      t.string :event
      t.string :user

      t.timestamps
    end
  end
end
