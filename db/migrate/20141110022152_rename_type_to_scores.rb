class RenameTypeToScores < ActiveRecord::Migration
  def change
  	rename_column :scores, :type, :pointer
  end
end
