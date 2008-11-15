

# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Commentaires"
    xml.description "Les derniers commentaires"
    xml.link formatted_comments_url(:rss)
    
    for comment in @comment
      xml.item do
        xml.title "Titre : "+comment.title
        xml.description comment.comment
        xml.pubDate comment.created_at.to_s(:rfc822)
        if comment.commentable_type == "Menu" then
          xml.link menu_url(comment.commentable_id)
          end
        #xml.guid polymorphic_url(comment)
      end
    end
  end
end

