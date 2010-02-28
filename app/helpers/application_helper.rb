# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Request from an iPhone or iPod touch? (Mobile Safari user agent)
  def iphone_user_agent?
    #request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
    request.user_agent =~ /(Mobile\/.+Safari)/
  end
  
  
  def select2_tag(name, option_tags = nil, options = {})
    html_name = (options[:multiple] == true && !name.to_s.ends_with?("[]")) ? "#{name}[]" : name
    content_tag :select, option_tags, { "name" => html_name, "id" => sanitize_to_id(name) }.update(options.stringify_keys)
  end

  def toggle_tag(val1,val2)
    #obj = instance_variable_get("@#{object_name}")
    value = "OFF" 
    hidden = hidden_field_tag("methode1", value, 
        :id => "methode1")
    thumb = content_tag(:span, "", :class => "thumb")
    on = content_tag(:span, val1, :class => "toggleOn")
    off = content_tag(:span, val2, :class => "toggleOff")
    toggle = content_tag(:div, thumb + on + off, 
            :toggled => value,
            :class => "toggle",
            :id => "test_toggle",
            :onclick => "$('methode1.value = ($('methode1.value == 'OFF') ? 'ON' : 'OFF';")
    row = content_tag(:div, toggle, :class => "row")
    hidden + row
  end

end
