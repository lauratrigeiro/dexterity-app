class AddIndexToUsers < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, :null => false
    change_column :users, :username, :string, :default => ""
    add_index :users, :username, unique: true
  end
end
