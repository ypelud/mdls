require File.dirname(__FILE__) + "/../test_helper"

class UseradmControllerTest < ActionController::TestCase
  
  fixtures :users
  
  def setup
    activate_authlogic
  end
  
  def test_should_not_list_not_login
    get :list
    assert_response :redirect
    assert_redirected_to :root
    assert !assigns(:users)
  end

  def test_should_login
    UserSession.create(users(:quentin))
    
    get :list
    assert_response :success
    assert assigns(:users)
  end

end
