class DeleteDraft < ActiveRecord::Migration[7.0]
  def change
   drop_table :drafts 
  end
end
