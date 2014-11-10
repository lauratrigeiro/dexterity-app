class RenameLevelColumnAsCourse < ActiveRecord::Migration
  def change
  	rename_column :scores, :level, :course
  end
end
