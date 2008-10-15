class CreateProfils < ActiveRecord::Migration
  def self.up
    create_table "profils", :force => true do |t|
      t.column "layout_name", :string, :default => ""
      t.column "style_menu", :string, :default => ""
      t.column "user_id", :integer, :default => 0, :null => false
    end
    add_index "profils", ["user_id"], :name => "fk_profils_user"
  end

  def self.down
   drop_table :profils
  end
end
