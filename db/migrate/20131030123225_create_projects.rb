class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :category
      t.string :number
      t.datetime :release_date
      t.string :name
      t.datetime :submit_date
      t.datetime :testup
      t.decimal :estimation
      t.text :urls
      t.text :content
      t.integer :user_id
      t.boolean :draft
      t.string :image_file 
      t.timestamps
    end
  end
end
