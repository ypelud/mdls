require File.dirname(__FILE__) + "/../test_helper"

class CommentsControllerTest < ActionController::TestCase
   
  fixtures :users, :menus, :comments, :menutypes
  
  def setup
    @controller = CommentsController.new
    @request    = ActionController::TestRequest.new
    @request.env['HTTP_REFERER'] = 'http://back'
    
    @response   = ActionController::TestResponse.new
    activate_authlogic
  end
  
  def test_should_list
    get :list, :id => Menu.first
    assert_response :success
    assert assigns(:menu)
    assert_template 'list'
  end
  
  def test_should_not_new_without_login    
    post :new, {:id => Menu.first}, {:comment => 'mon commentaire'}
    assert_response :redirect
    assert_redirected_to 'http://back'
  end
  
  def test_should_new_with_login
    UserSession.create(users(:aaron))
    get :list, :id => 1
    post :new, {:id => 1}, {:comment => 'mon commentaire'}
    assert_response :success
  end
  
  def test_create_invalid
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_redirected_to 'http://back'
  end
  
  
end
