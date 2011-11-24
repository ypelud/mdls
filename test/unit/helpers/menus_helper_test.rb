require File.dirname(__FILE__) + "/../../test_helper"

class MenusHelperTest < ActionView::TestCase
  
  
  def test_menuposition
    assert_equal menu_position, ''
    assert_equal menu_position, 'even'
    assert_equal menu_position, ''
    assert_equal menu_position, 'even'
  end
  
end
