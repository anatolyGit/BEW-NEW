class ChangeColumnName < ActiveRecord::Migration
  def up
  	  rename_column :actions, :title, :charge_name
  end

  def down
  end
end
