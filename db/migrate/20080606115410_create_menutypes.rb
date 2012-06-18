class CreateMenutypes < ActiveRecord::Migration
  def self.up
		create_table :menutypes do |t|
	    t.column :name, :string, :limit => 50, :null => false
	  end
	  Menutype.create :name => "midi"
    Menutype.create :name => "soir"  
  end

  def self.down
		drop_table :menutypes
  end
end
