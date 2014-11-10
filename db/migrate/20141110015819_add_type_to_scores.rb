class AddTypeToScores < ActiveRecord::Migration
  def change
    add_column :scores, :type, :string
    add_column :scores, :hand, :string
  end
end
