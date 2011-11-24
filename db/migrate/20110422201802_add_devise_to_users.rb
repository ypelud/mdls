class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    remove_index :users, :last_request_at

    rename_column :users, :crypted_password, :encrypted_password
    add_column :users, :reset_password_token, :string, :limit => 255
    
    add_column :users, :remember_token, :string, :limit => 255
    add_column :users, :remember_created_at, :timestamp
    
    rename_column :users, :login_count, :sign_in_count
    rename_column :users, :current_login_at, :current_sign_in_at
    rename_column :users, :last_login_at, :last_sign_in_at
    rename_column :users, :current_login_ip, :current_sign_in_ip
    rename_column :users, :last_login_ip, :last_sign_in_ip
    
    rename_column :users, :failed_login_count, :failed_attempts
    
    remove_column :users, :persistence_token
    
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true

    # add_index :deviseusers, :confirmation_token,   :unique => true
    # add_index :deviseusers, :unlock_token,         :unique => true
    # add_index :deviseusers, :authentication_token, :unique => true
  end

  def self.down
    #TODO
  end
end
