require File.dirname(__FILE__) + "/../test_helper"

class PlanningsControllerTest < ActionController::TestCase
    
  fixtures :users, :plannings, :menuslistes
  
  def setup
    activate_authlogic
  end
  
  def test_should_get_index_without_login
    get :index
    
    assert_response :success  
    plannings = assigns(:plannings)
    assert plannings
    assert_equal 1, plannings.size
  end

  def test_should_get_index_with_login
    UserSession.create(users(:aaron))
    get :index
    
    assert_response :success  
    plannings = assigns(:plannings)
    assert plannings

    assert_equal 2, plannings.size
  end
  
  def test_should_not_edit_whitout_login
    get :edit, :id => 1
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_not_edit_not_owner
    UserSession.create(users(:aaron))
    get :edit, :id => 1
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_edit_owner
    UserSession.create(users(:quentin))
    get :edit, :id => 1
    assert_response :success
    assert_template :edit
  end

  def test_should_edit_admin
    UserSession.create(users(:quentin))
    get :edit, :id => 2
    assert_response :success
    assert_template :edit
  end
  
  def test_should_not_new_without_login
    get :new
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_new_with_login
    UserSession.create(users(:quentin))
    get :new
    assert_response :success
    assert_template :new
  end
  
  def test_should_not_create_without_login
    create_planning
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_create_with_login
    UserSession.create(users(:quentin))
    create_planning
    assert_response :redirect
    assert_redirected_to :plannings
  end
  
  def test_should_destroy_with_login
    UserSession.create(users(:quentin))
    get :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :plannings

    assert_nil Menusliste.find_by_id(1)
    assert_nil Menusliste.find_by_id(2)
    assert_not_nil Menusliste.find_by_id(3)
    assert_nil Planning.find_by_id(1)
    assert_not_nil Planning.find_by_id(2)
  end

  def test_should_not_destroy_without_login
    get :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :root
  end
  
protected 
  def create_planning(options = {})
    post :create, :planning => { :name => 'test', :public => false }.merge(options)
  end

  
end
