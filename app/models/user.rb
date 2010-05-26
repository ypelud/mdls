class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.transition_from_restful_authentication = true
  end
end
