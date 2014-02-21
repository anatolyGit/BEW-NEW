class CreatePaLinks < ActiveRecord::Migration
  def change
    create_table :pa_links do |t|
      t.integer :project_id 
      t.integer :status_id 
      t.timestamps
    end
  end
end
