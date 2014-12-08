class ChangeTimeFormatInScores < ActiveRecord::Migration
  def up
   change_column :scores, :time, :integer
  end

  def down
   change_column :scores, :time, :string
  end
end
