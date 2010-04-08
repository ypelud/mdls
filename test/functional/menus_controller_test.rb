require File.dirname(__FILE__) + "/../test_helper"

class MenusControllerTest < ActionController::TestCase
  fixtures :users

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(@menus)
  end

end
