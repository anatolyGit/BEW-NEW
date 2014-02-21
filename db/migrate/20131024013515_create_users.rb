class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :crypted_password
      t.integer :authority, :default => 0

      t.timestamps
    end
  end
end
