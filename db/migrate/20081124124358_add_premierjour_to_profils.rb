class AddPremierjourToProfils < ActiveRecord::Migration
  def self.up
    add_column :profils, :first_day, :string
  end

  def self.down
    remove_column :profils, :first_day
  end

end
