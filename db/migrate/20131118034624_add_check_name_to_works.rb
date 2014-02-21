class AddCheckNameToWorks < ActiveRecord::Migration
  def change
  	add_column :works, :check_name, :string
  end
end
