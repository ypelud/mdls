require "migration_helpers" 

class CreatePlannings < ActiveRecord::Migration
  extend MigrationHelpers
  
  def self.up
    create_table :plannings, :force => true do |t|
      t.column :name, :string
      t.column :public, :boolean, :default => true
      t.column :user_id, :integer, :default => 0, :null => false     
      t.timestamps      
    end  
	foreign_key(:plannings, :user_id, :users, :id)    
  end

  def self.down
    drop_table :plannings
  end
end
