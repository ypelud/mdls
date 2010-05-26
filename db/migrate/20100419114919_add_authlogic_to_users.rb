class AddAuthlogicToUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :crypted_password, :string, :limit => 128,
      :null => false, :default => ""

    change_column :users, :salt, :string, :limit => 128,
      :null => false, :default => ""
    rename_column :users, :salt, :password_salt
    
      
    add_column :users, :persistence_token, :string, :null => false, :default => ""
    
    add_column :users, :login_count, :integer, :null => false, :default => 0
    add_column :users, :failed_login_count, :integer,  :null => false, :default => 0
    add_column :users, :last_request_at, :datetime
    add_column :users, :current_login_at, :datetime
    add_column :users, :last_login_at, :datetime
    add_column :users, :current_login_ip, :string
    add_column :users, :last_login_ip, :string     
    
    remove_column :users, :created_at
    remove_column :users, :updated_at
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
    remove_column :users, :activation_code
    remove_column :users, :activated_at
    remove_column :users, :reset_code
    
    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :last_request_at
     
  end

  def self.down
  end
end
