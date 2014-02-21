class RenameCryptedPasswordToUser < ActiveRecord::Migration
  def up
    rename_column :users, :crypted_password, :password_digest
  end

  def down
    rename_column :users, :password_digest, :crypted_password
  end
end
