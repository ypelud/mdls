require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de edit
describe RechercheController, "GET /new" do  
  
  it "should render partial" do
    get :new
    response.should render_template(:new)
  end

end

describe RechercheController, "GET /find" do  
  
  it"should redirect to menus" do
    get :find, :mot => "test"
    response.should redirect_to(:controller => 'menus', :action => 'index', :tags_id => "test")
  end
  
end

