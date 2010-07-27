require File.dirname(__FILE__) + "/../test_helper"

class MenutypesControllerTest < ActionController::TestCase
  
  fixtures :all

  def setup
    @controller = MenutypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    activate_authlogic
  end
  
  def test_should_login
    get :index
    assert_response :redirect
    assert_redirected_to :root

    get :list
    assert_response :redirect
    assert_redirected_to :root

    get :show, {:id => 1}
    assert_response :redirect
    assert_redirected_to :root
  end
  
  def test_should_get_index
    UserSession.create(users(:quentin))
    get :index
    assert_response :success  
    profil = assigns(:menutypes)
  end
  
  def test_should_show
    UserSession.create(users(:quentin))
    get :show, {:id => 1}
    assert_response :success  
    assert assigns(:menutype)
    assert_equal assigns(:menutype).name, 'midi'
  end
  
  def test_should_fail_create_not_login
    post :create
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_create
    assert_difference 'Menutype.count' do
      UserSession.create(users(:quentin))
      post :create, :menutype => {:name => 'test'}
      assert_response :redirect
      assert_redirected_to menutypes_path
    end
  end
  
  def test_should_do_nothing_fail_save
    Menutype.any_instance.stubs(:save).returns(false)
    assert_no_difference 'Menutype.count' do
      UserSession.create(users(:quentin))
      post :create, :menutype => {:name => 'test'}
      assert_response :success
    end
  end
  
  def test_should_new
    UserSession.create(users(:quentin))
    get :new
    assert :success
    assert assigns(:menutype)
  end

  def test_should_fail_new_not_login
    get :new
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_edit
    UserSession.create(users(:quentin))
    get :edit, :id => 1
    assert :success
    assert assigns(:menutype)
  end

  def test_should_fail_edit_not_login
    get :edit, :id => 1
    assert_response :redirect
    assert_redirected_to :root
  end
    
  def test_should_update
    UserSession.create(users(:quentin))
    Menutype.any_instance.stubs(:update_attributes).returns(true)
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to menutype_path(1)
  end

  def test_should_fail_update_not_login
    post :update, :id => 1, :menutype => {:name => 'test'}
    assert_response :redirect
    assert_redirected_to :root
  end
  
  def test_should_fail_update_attributes
    UserSession.create(users(:quentin))
    Menutype.any_instance.stubs(:update_attributes).returns(false)
    post :update, :id => 1, :menutype => {:name => 'test'}
    assert_response :success
    assert_template :edit
  end

  def test_should_destroy
    UserSession.create(users(:quentin))
    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to menutypes_path
  end
  
  def test_should_fail_destroy_not_login
    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :root
  end
  
end
