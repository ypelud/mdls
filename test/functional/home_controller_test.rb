require File.dirname(__FILE__) + "/../test_helper"

class HomeControllerTest < ActionController::TestCase

  fixtures :users, :menus

  def test_should_sidebar
    get :sidebar
    assert_response :success
  end

  def test_should_compteur
    get :compteur
    assert_response :success
    assert assigns(:nbM)
    assert assigns(:nbC)
    assert assigns(:nbM),  2
    assert assigns(:nbC),  1
  end
  
  def test_should_comment
    get :comment
    assert_response :success
  end
  
end
