class CreateEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluations do |t|
      t.string :event
      t.string :user
      t.integer :value

      t.timestamps
    end
  end
end
