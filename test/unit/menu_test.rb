require File.dirname(__FILE__) + "/../test_helper"

class MenuTest < ActiveSupport::TestCase
  fixtures :menutypes, :users, :menus
  
  def test_should_create_menu
    assert_difference 'Menu.count' do
      menu = create_menu()
      assert !menu.new_record?, "#{menu.errors.full_messages.to_sentence}"
    end
  end
  
  def test_should_require_user
    assert_no_difference 'Menu.count' do      
      menu = create_menu(:user => nil)
      assert menu.errors.on(:user)
    end
  end

  def test_should_require_menutype
    assert_no_difference 'Menu.count' do
      menu = create_menu(:menutype => nil)
      assert menu.errors.on(:menutype)
    end
  end
  
  def test_should_require_title
    assert_no_difference 'Menu.count' do
      menu = create_menu(:title => nil)
      assert menu.errors.on(:title)
    end
  end
  

protected
  def create_menu(options = {})
    menutype = menutypes(:midi)
    user = users(:quentin)
    record = Menu.new({ :menutype => menutype, :user => user, \
      :title => 'Mon deuxieme menu', :description => 'voila mon deuxieme menu' }.merge(options))
    record.save
    record
  end
end
