# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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

    def messages_error(object)
      if object and object.errors.any? then
        error_messages = object.errors.full_messages.map do |msg| 
          content_tag(:li, msg)
        end.join.html_safe

        contents = ''
        contents << content_tag(:h2, t("activerecord.errors.template.body")) 
        #contents << content_tag(:p, message) unless message.blank?
        contents << content_tag(:ul, error_messages)
        content_tag(:div, contents.html_safe, :id => 'errorExplanation')
      else
        ''
      end
    end


    def selected_menu(name)
      if @selectedMenu == name
        return 'ui-state-active'
      end
      ''
    end

    def notify_flash
       ret = "<div id='flash'>"
       ret << flash[:notice] unless flash[:notice].blank? 
       ret << flash[:error] unless flash[:error].blank? 
       ret << "</div>"
       return ret.html_safe
    end

    def summary(comment, len = 50)
      return comment[0,len] << "..." if comment.length>len
      return comment
    end
end
