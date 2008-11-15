class AddIngredientsToMenus < ActiveRecord::Migration
  def self.up
    add_column :menus, :ingredients, :text
  end

  def self.down
    remove_column :menus, :ingredients
  end
end
