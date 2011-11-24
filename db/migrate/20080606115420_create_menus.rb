#require "migration_helpers" 

class CreateMenus < ActiveRecord::Migration

  def self.up
		create_table :menus do |t|
		   t.column :menutype_id, :integer, :null => false
		   t.column :user_id, :integer, :null => false
		   t.column :title, :string, :default => "", :null => false
		   t.column :date, :date
		   t.column :description, :text
		end
	add_index :menus, ["menutype_id"], :name => "fk_menus_menutype"
  add_index :menus, ["user_id"], :name => "fk_menus_user"
  end

  def self.down
		drop_table :menus
  end

end
