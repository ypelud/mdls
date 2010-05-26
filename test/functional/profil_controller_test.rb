require File.dirname(__FILE__) + "/../test_helper"

class ProfilControllerTest < ActionController::TestCase
    
  fixtures :users, :profils
  
  def setup
    @controller = ProfilController.new
    @request    = ActionController::TestRequest.new
    @request.env['HTTP_REFERER'] = 'http://back'
    @response   = ActionController::TestResponse.new
    activate_authlogic
    
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
    UserSession.create(users(:aaron))
    
    get :edit
    assert_response :success
    assert_not_nil assigns(:profil)
    profil = assigns(:profil)
    assert_equal profil.layout_name, ''
    assert_equal profil.style_menu, 'semaine_style'
  end
  
  def test_should_update
    UserSession.create(users(:aaron))
    post :update, {:id => '2'}, :profil => { :id => 2, :user_id => 2,\
       :layout_name => 'test', :style_menu => 'liste_style'}
    assert_response :redirect
    assert_redirected_to 'http://back'
  end
  
end
