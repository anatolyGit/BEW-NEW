class ChangeTypeOfEstimationInProjects < ActiveRecord::Migration
  def up
    change_column :projects, :estimation, :float
  end

  def down
    change_column :projects, :estimation, :decimal
  end
end
