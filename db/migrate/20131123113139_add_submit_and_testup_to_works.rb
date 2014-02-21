class AddSubmitAndTestupToWorks < ActiveRecord::Migration
  def change
  	add_column :works, :submit_date, :datetime
  	add_column :works, :testup, :datetime 	
  end
end
