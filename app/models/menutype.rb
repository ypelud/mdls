class Menutype < ActiveRecord::Base
	has_many :menus 
	attr_accessible :name
end
