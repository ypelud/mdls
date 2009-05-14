class CreateMenuslistes < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :menuslistes, :force => true  do |t|
      t.column :day, :integer, :default => 0
      t.column :when, :integer, :default => 0
      t.column :planning_id, :integer, :default => 0, :null => false
      t.column :menu_id, :integer, :default => 0, :null => false
    end
	foreign_key(:menuslistes, :planning_id, :plannings, :id)        
	foreign_key(:menuslistes, :menu_id, :menus, :id)        
  end

  def self.down
    drop_table :menuslistes
  end
end
