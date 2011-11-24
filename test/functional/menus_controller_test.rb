require File.dirname(__FILE__) + "/../test_helper"

class MenusControllerTest < ActionController::TestCase

  fixtures :users, :menus, :menutypes

  def setup
    @controller = MenusController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    activate_authlogic
  end
  
  def test_should_show
    get :show, :id => 1
    assert_response :success
    assert assigns(:menu)
  end
    
  def test_should_create
    assert_difference 'Menu.count' do
      UserSession.create(users(:aaron))
      create_menu
      assert_response :redirect
      assert_redirected_to menus_url
    end
  end
  
  def test_should_not_create_until_login
    assert_no_difference 'Menu.count' do
      create_menu
      assert_response :redirect
      assert_redirected_to :root
    end
  end
  
  def test_should_failed_on_save
    Menu.any_instance.stubs(:save).returns(false)
    assert_no_difference 'Menu.count' do
      UserSession.create(users(:aaron))
      create_menu
      assert_response :success
      assert_template :new
    end
  end
  
  def test_should_new
    UserSession.create(users(:aaron))
    get :new
    assert_response :success
    assert assigns(:menu)
  end
  
  def test_should_fail_new_not_login
    get :new
    assert_response :redirect
    assert_redirected_to :root
  end
  
  def test_should_edit_if_login
    UserSession.create(users(:aaron))
    get :edit, :id => '1'
    assert_response :success
    assert assigns(:menu)
  end

  def test_should_fail_edit_not_login
    get :edit, :id => '1'
    assert_response :redirect
    assert_redirected_to :root
  end
  
  def test_should_fail_edit_no_id
    get :edit
    assert_response :redirect
    assert_redirected_to :root
  end
  
  def test_should_fail_edit_if_login_wrong
    UserSession.create(users(:aaron))
    get :edit, :id => '2'
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_edit_if_login_admin
    UserSession.create(users(:quentin))
    get :edit, :id => '1'
    assert_response :success
    assert assigns(:menu)
  end
  
  def test_should_update
    UserSession.create(users(:aaron))
    Menu.any_instance.stubs(:update_attributes).returns(true)
    post :update, :id => 3, :menu => {:menutype => menutypes(:midi)}
    assert_response :redirect
    assert_redirected_to menu_path(3)
  end

  def test_should_update_if_admin
    UserSession.create(users(:quentin))
    Menu.any_instance.stubs(:update_attributes).returns(true)
    post :update, :id => 3
    assert_response :redirect
    assert_redirected_to menu_path(3)
  end

  def test_should_fail_update_not_login
    Menu.any_instance.stubs(:update_attributes).returns(true)
    post :update, :id => 3
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_fail_update_if_login_wrong
    Menu.any_instance.stubs(:update_attributes).returns(true)
    UserSession.create(users(:aaron))
    post :update, :id => 2
    assert_response :redirect
    assert_redirected_to :root
  end
  
  def test_should_fail_update_attributes
    UserSession.create(users(:aaron))
    Menu.any_instance.stubs(:update_attributes).returns(false)
    post :update, :id => 1
    assert_response :success
    assert_template :edit
  end
  

  def test_should_fail_destroy_not_login
    assert_no_difference 'Menu.count' do
      post :destroy, :id => '1'
      assert_response :redirect
      assert_redirected_to :root
    end
  end

  def test_should_destroy_if_login
    assert_difference 'Menu.count', -1 do
      UserSession.create(users(:aaron))
      post :destroy, :id => '3'
      assert_response :redirect
      assert_redirected_to menus_url
    end
  end

  def test_should_fail_destroy_if_login_wrong
    assert_no_difference 'Menu.count' do
      UserSession.create(users(:aaron))
      post :destroy, :id => '2'
      assert_response :redirect
      assert_redirected_to :root
    end
  end
  
  def test_should_destroy_if_login_admin
    assert_difference 'Menu.count', -1 do
      UserSession.create(users(:quentin))
      post :destroy, :id => '3'
      assert_response :redirect
      assert_redirected_to menus_url
    end
  end

  def test_should_feed
    get :feed, :format => 'rss'
    assert_response :success
    #assert_redirected_to :home
  end
  
  def test_should_feed_url
    get :feedurl
    assert_response :redirect
    assert_redirected_to 'http://feeds2.feedburner.com/Menusdelasemaine'
  end
  
protected
  def create_menu(options = {})
    menutype = menutypes(:midi)
    post :create, :menu => { :menutype => menutype, :title => 'Mon autre menu', \
      :description => 'voila mon autre menu', :ingredients => 'un deux trois', \
      :url => 'http://localhost:3000'}.merge(options)
  end
  

end
