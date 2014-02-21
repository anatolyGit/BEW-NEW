class AddAttachedFileToActions < ActiveRecord::Migration
  def change
    add_column :actions, :attached_file, :string
  end
end
