class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :pa_link_id
      t.string :title
      t.string :contact
      t.string :jobs
      t.float :estimation
      t.datetime :release_date
      t.string :urls
      t.string :appended
      t.datetime :deleted_at
      t.integer :updated_user_id
      t.float :track 
      t.timestamps
    end
  end
end
