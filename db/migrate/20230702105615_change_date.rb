class ChangeDate < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :date, :date
    change_column :drafts, :date, :date

  end
end
