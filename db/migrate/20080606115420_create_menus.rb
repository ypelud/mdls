require "migration_helpers" 

class CreateMenus < ActiveRecord::Migration
  	extend MigrationHelpers
  def self.up
		create_table :menus do |t|
		   t.column :menutype_id, :integer, :null => false
		   t.column :user_id, :integer, :null => false
		   t.column :title, :string, :default => "", :null => false
		   t.column :date, :date
		   t.column :description, :text
		end
	foreign_key(:menus, :user_id, :users, :id)
	foreign_key(:menus, :menutype_id, :menutypes, :id)
  end

  def self.down
		drop_table :menus
  end

end
