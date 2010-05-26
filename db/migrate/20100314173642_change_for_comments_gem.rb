class ChangeForCommentsGem < ActiveRecord::Migration
  def self.up
    #execute "DROP INDEX `fk_comments_user` ON comments"
    
    change_column :comments, :commentable_id,  :integer,  :default => nil, :null => true
    change_column :comments, :commentable_type, :string,  :default => nil, :null => true
    change_column :comments, :user_id, :integer,  :default => nil, :null => true
    change_column :comments, :created_at, :datetime,  :default => nil, :null => true

    add_column :comments, :updated_at, :datetime

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
    add_index :comments, :user_id
  end

  def self.down
    remove_index :comments, :user_id
    remove_index :comments, :commentable_id
    remove_index :comments, :commentable_type
    
    remove_column :comments, :updated_at
    
    
    change_column :comments, :user_id, :integer, :default => 0, :null => false
    change_column :comments, :commentable_type, :string, :limit => 15, :default => "", :null => false
    change_column :comments, :commentable_id, :integer, :default => 0, :null => false

    add_index "comments", ["user_id"], :name => "fk_comments_user"    
  end
end
