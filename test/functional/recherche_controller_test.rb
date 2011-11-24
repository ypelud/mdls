require File.dirname(__FILE__) + "/../test_helper"

class RechercheControllerTest < ActionController::TestCase

  def test_should_new
    get :new
    assert_response :success
    assert assigns(:search)
    #assert assigns(:tags)
  end
  
  def test_should_update
    get :update, {:mot => "test"}
    assert_response :redirect
    assert_redirected_to :controller => :menus, :tags_id => "test"
  end
end
