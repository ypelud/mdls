require File.dirname(__FILE__) + "/../test_helper"

class TagsControllerTest < ActionController::TestCase
  
  def test_should_tags
    get :index
    assert_response :success
    assert assigns(:tags)
  end
  
end
