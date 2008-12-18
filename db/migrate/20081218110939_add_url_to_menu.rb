class AddUrlToMenu < ActiveRecord::Migration
  def self.up
    add_column :menus, :url, :string
  end

  def self.down
    remove_column :menus, :url
  end
end
