module CommentsHelper

  def comments(number)
    comments = Comment.find(:all, :order => "created_at desc", :limit => number)
  end
  
  def menu_from_comment(comment)
    rel=Comment.find_commentable(comment.commentable_type, comment.commentable_id)
    rel=rel.first if rel.class!=Menu
    @menu = Menu.find_by_id(rel.id) 
  end 
  
  def summary(comment)
    len = 50
    return comment[0,len] << "..." if comment.length>len
  end
end
