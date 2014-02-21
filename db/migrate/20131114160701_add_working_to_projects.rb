class AddWorkingToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :working, :string
  end
end
