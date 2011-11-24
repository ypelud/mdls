require File.dirname(__FILE__) + "/../test_helper"

class ChoixmenuControllerTest < ActionController::TestCase
  fixtures :menuslistes
  
  def setup
    @controller = ChoixmenuController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_should_empty_session_choix
    post :add, :id => '1'
    post :empty
    assert_equal session[:choix].length, 0, "session[:choix] doit etre vide"
  end
  
  def test_should_add_session_choix
    get :empty
    assert_difference 'session[:choix].length' do
      post :add, :id => '1'
      assert_response :success
      assert_equal @response.body, "#{session[:choix].length} menu(s)"
    end
  end
  
  def test_should_duplicate_entries
    post :add, :id => '1'
    assert_difference 'session[:choix].length' do
      post :add, :id => '1'
      assert_response :success
    end
  end
  
  def test_should_remove_session_choix
    post :add, :id => '1'
    assert_difference 'session[:choix].length' , -1 do
      post :remove, :id => '1'
      assert_response :success
      assert_equal @response.body, "#{session[:choix].length} menu(s)"
    end
  end
  
  def test_should_apply
    get :apply, :id => 1
    assert assigns(:planning)
    assert_response :redirect
    assert_redirected_to :root
  end
  
end
