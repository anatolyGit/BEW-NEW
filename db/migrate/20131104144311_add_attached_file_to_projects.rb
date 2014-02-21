class AddAttachedFileToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :attached_file, :string
  end
end
