class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    add_column :taggings, :context, :string, :default => "tags"      
  end

  def self.down
    remove_column :taggings, :context
  end
end
