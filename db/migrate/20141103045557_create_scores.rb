class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :time
      t.integer :level
      t.references :user, index: true

      t.timestamps null:false
    end
    add_index :scores, [:user_id, :created_at]
    add_index :scores, [:user_id, :time]
    add_index :scores, :time
  end
end
