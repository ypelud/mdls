class CreateMenuslistes < ActiveRecord::Migration

  def self.up
    create_table :menuslistes, :force => true  do |t|
      t.column :day, :integer, :default => 0
      t.column :when, :integer, :default => 0
      t.column :planning_id, :integer, :default => 0, :null => false
      t.column :menu_id, :integer, :default => 0, :null => false
    end
    
	add_index :menuslistes, ["planning_id"], :name => "fk_menuslistess_planning"
	add_index :menuslistes, ["menu_id"] , :name => "fk_menuslistes_user"
  end

  def self.down
    drop_table :menuslistes
  end
end
