class RenameActionTableName < ActiveRecord::Migration
  def up
  	rename_table :actions, :works
  end

  def down
  end
end
