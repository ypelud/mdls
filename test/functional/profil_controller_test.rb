require File.dirname(__FILE__) + "/../test_helper"

class ProfilControllerTest < ActionController::TestCase
    
  fixtures :all
  
  def setup
    @controller = ProfilsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    activate_authlogic
    @request.env['HTTP_REFERER'] = 'http://back'
  end
  
  def test_should_failed_if_not_login
    get :edit
    assert_response :redirect
    assert_redirected_to 'http://back'
  end
  
  def test_should_edit
    UserSession.create(users(:quentin))
    get :edit
    assert_response :success
    assert_not_nil assigns(:profil)
    profil = assigns(:profil)
    assert_equal profil.layout_name, 'lay1'
    assert_equal profil.style_menu, 'liste_style'
  end

  def test_should_create_and_edit
    UserSession.create(users(:bob))
    get :edit
    assert_response :success
    assert_not_nil assigns(:profil)
    profil = assigns(:profil)
    assert_equal profil.layout_name, ''
    assert_equal profil.style_menu, 'semaine_style'
  end
  
  def test_should_update
    user = UserSession.create(users(:quentin))
    Profil.any_instance.stubs(:update_attributes).returns(true)
    post :update
    assert_response :redirect
    assert_redirected_to :root
  end

  def test_should_failed_update
    user = UserSession.create(users(:quentin))
    Profil.any_instance.stubs(:update_attributes).returns(false)
    post :update
    assert_response :redirect
    assert_redirected_to edit_user_profil_path(users(:quentin))
  end
  
  def test_should_create_and_update
    user = UserSession.create(users(:aaron))
    Profil.any_instance.stubs(:update_attributes).returns(true)
    post :update
    assert_response :redirect
    assert_redirected_to :root
  end
  
end
