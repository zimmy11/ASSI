class RemoveFkPresalesEvents < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key "presales","events"
  end
end
