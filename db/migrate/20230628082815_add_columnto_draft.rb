class AddColumntoDraft < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :drafts,:user
  end
end
