class UpdateCOlumn < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :presales_left,:integer
    add_column :events , :avgvalue,:float
  end
end
