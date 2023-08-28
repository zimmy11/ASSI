class AddDistance < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :distance, :float
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
