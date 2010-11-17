class Menusliste < ActiveRecord::Base
  belongs_to :planning
  
  attr_accessor :guid
  
  def after_initialize
      # do stuff
      @guid = Guid.new
  end  
end
