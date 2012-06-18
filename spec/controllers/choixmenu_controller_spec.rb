require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de empty
describe ChoixmenuController, "GET /empty" do
  before(:each) do
    request.env["HTTP_REFERER"] = "/where_i_came_from"
    session[:choix] = ["123"]
  end
    
  it "redirects back to the referring page" do
    get :empty
    response.should redirect_to "where_i_came_from"
  end

  it "empty the session[:choix]" do
    get :empty
    session[:choix].should == []
  end

end


# test de list
describe ChoixmenuController, "GET /list" do
    
  it "should render menu_list partial" do
    get :list
    controller.should render_template(:menu_list) 
  end

  it "should keep session[:choix]" do
    session[:choix] = ["123"]
    get :list
    session[:choix].should == ["123"]
  end

  it "should initialize the session[:choix]" do
    session[:choix]=nil
    get :list
    session[:choix].should == []
  end

end


# test de list
describe ChoixmenuController, "GET /apply" do
    
  before(:each) do
    request.env["HTTP_REFERER"] = "/where_i_came_from"
    session[:choix] = ["123"]
    Planning.stub!(:find).with('1').and_return(@planning = mock_model(Planning, :save=>false))
    @planning.should_receive(:menuslistes).and_return(["123","456"])
  end
    
  it "redirects back to the referring page" do
    get :apply, :id => 1
    response.should redirect_to "where_i_came_from"
  end

  it "fill the session[:choix]" do
    get :apply, :id => 1
    session[:choix].count.should == 2
    session[:choix][0].should =="123"
    session[:choix][1].should =="456"
  end

end


# test de add
describe ChoixmenuController, "GET /add" do
    
  before(:each) do
    Menusliste.stub!(:new).and_return(@menusliste = mock_model(Menusliste))
    @menusliste.should_receive(:day=)
    @menusliste.should_receive(:when=)
    @menusliste.should_receive(:menu_id=)
  end
    
  it "render partial cart" do
    get :add, {:id => "mnu_1", :day => "lundi", :midisoir => "midi"}
    controller.should render_template(:cart) 
  end
  
  it "should add menuliste to session[:choix]" do
    get :add, {:id => "mnu_1", :day => "lundi", :midisoir => "midi"}
    session[:choix].count.should == 1
    session[:choix][0].should == @menusliste
  end


end


# test de remove
describe ChoixmenuController, "GET /remove" do
    
  before(:each) do
    @menusliste = mock_model(Menusliste)
    @menusliste.stub!(:day).and_return(0)
    @menusliste.stub!(:when).and_return(0)
    @menusliste.stub!(:menu_id).and_return("mnu_1")
    session[:choix] = [@menusliste]
  end
    
  it "render partial cart" do
    get :remove, {:id => "mnu_1", :day => "lundi", :midisoir => "midi"}
    controller.should render_template(:cart) 
  end
  
  it "should remove menuliste from session[:choix]" do
    get :remove, {:id => "mnu_1", :day => "lundi", :midisoir => "midi"}
    session[:choix].count.should == 0
  end


end
