module MenusHelper
  def tag_cloud(tags, classes)
       max, min = 0, 0 
       tags.each { |t| 
         max = t.count.to_i if t.count.to_i > max 
         min = t.count.to_i if t.count.to_i < min 
      }

      divisor = ((max - min) / classes.size) + 1 

      tags.each { |t|
         yield t.name, classes[(t.count.to_i - min) / divisor]
      }
  end
  
  def tag_counts()
    Menu.tag_counts(:limit => 20, :order=>'Random()' ) 
  end
  
end
