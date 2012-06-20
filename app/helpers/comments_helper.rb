module CommentsHelper

  def last_five_comments
    Comment.find(:all, :order => "created_at desc", :limit => 3)
  end
  
end

