module TagsHelper
  def tag_cloud(classes) 
     # tags = Menu.tag_counts(:limit => 20, :order => :random ) 
     
     tags = Menu.tag_counts(:limit => 20)

     max, min = 0, 0 
     tags.each { |t| 
       max = t.count.to_i if t.count.to_i > max 
       min = t.count.to_i if t.count.to_i < min 
     }

     divisor = ((max - min) / classes.size) + 1 

     tags.each { |t|
       yield t, classes[(t.count.to_i - min) / divisor]
     }
   end
end
