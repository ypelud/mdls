module CommentsHelper

  def comments(number)
    comments = Comment.find(:all, :order => "created_at desc", :limit => number)
  end
  
end
