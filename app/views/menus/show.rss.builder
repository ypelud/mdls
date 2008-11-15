

# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Menus"
    xml.description "Pleins de menus"
    xml.link formatted_menus_url(:rss)
    
    for menu in @menus
      xml.item do
        xml.title menu.title
        xml.description menu.description
        xml.pubDate menu.date.to_s(:rfc822)
        xml.link formatted_menu_url(menu, :rss)
        xml.guid formatted_menu_url(menu, :rss)
      end
    end
  end
end

