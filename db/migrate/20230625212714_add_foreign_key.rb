class AddForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_index :events,:title,unique:true
    add_index :users,:user_id,unique:true
    add_reference :drafts,:users

  end
end
