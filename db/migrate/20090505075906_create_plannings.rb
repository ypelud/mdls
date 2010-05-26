class CreatePlannings < ActiveRecord::Migration
  
  def self.up
    create_table :plannings, :force => true do |t|
      t.column :name, :string
      t.column :public, :boolean, :default => true
      t.column :user_id, :integer, :default => 0, :null => false     
      t.timestamps      
    end  
  	add_index :plannings, ["user_id"], :name => "fk_plannings_user"
  end

  def self.down
    drop_table :plannings
  end
end
