class RemoveColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :presales, :status, :integer
    remove_column :presales, :token, :string
    remove_column :presales, :error_message, :string
    remove_column :presales, :customer_id, :string
    remove_column :presales,:payment_gateway,:integer 
    remove_column :presales,:charge_id,:integer 
  end
end
