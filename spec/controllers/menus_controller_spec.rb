require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de show
describe MenusController, "show" do  
  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User, :login => "user"))
    Menu.stub!(:find).with('1').and_return(@menu = mock_model(Menu, :save=>false))
  end
        
  it "should find a menu" do
    Menu.should_receive(:find).with('1').and_return(@menu)
    get :show, :id => 1
  end
        
  it "should render show template" do
    get :show, :id => 1
    controller.should render_template(:show)
  end
            
  it "should assign menu" do
    get :show, :id => 1
    assigns[:menu].should == @menu
  end
  
  it "should render show if no current_user" do
    controller.stub!(:current_user).and_return(nil)
    get :show, :id => 1
    response.should_not redirect_to(home_path)
  end
end


# test de New
describe MenusController, "new" do
  before(:each) do    
    controller.stub!(:current_user).and_return(mock_model(User, :login => "user"))
    Menu.stub!(:new).and_return(@menu = mock_model(Menu, :save=>false))
  end
    
  it "should render show template" do
    get :new
    controller.should render_template(:new)
  end

  it "should create a new Menu" do
    get :new
    assigns[:menu].should == @menu
  end
  
  it "should not render new if no current_user" do
    controller.stub!(:current_user).and_return(nil)
    get :new
    response.should redirect_to(home_path)
  end
end


# test de Create
describe MenusController, "POST Create" do
  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User, :login => "user"))
    Time.stub!(:new)
    Menu.stub!(:new).and_return(@menu = mock_model(Menu))
    @menu.should_receive(:date=)
    @menu.should_receive(:user_id=)
  end

  describe 'with save succeed'  do
    before(:each) do   
      @menu.should_receive(:save).and_return(true)
    end
    
    it "should redirect to menus_path" do
      post :create, :menu => {  }
      controller.should redirect_to(menus_path)  
    end
  
    it "should assign value to flash[:notice]" do
      post :create, :menu => {  }
      flash[:notice].should_not be_nil
    end

  end

  describe  "with save failed" do
    before(:each) do    
      @menu.should_receive(:save).and_return(false)
    end
      
    it "should render create template" do
      post :create, :menu => { }
      controller.should render_template(:new) 
    end
  end
end

#test de recupere
describe MenusController, "recupere" do
  before(:each) do
    Menu.stub!(:tag_counts).and_return(@tags = "test")
  end
    
  it "should render partial " do
    get :recupere
    controller.should render_template(:tags_list) 
  end

  it "should assign @tags " do
    get :recupere
    assigns[:tags].should == @tags
  end

end

# test de Feedurl
describe MenusController, "feedurl" do
  it "should redirect to feedurl" do
    get :feedurl
    response.should redirect_to('http://feeds2.feedburner.com/Menusdelasemaine')
  end
end

# test de destroy
describe MenusController, "destroy" do
  before(:each) do
    controller.stub!(:authorize).and_return(true)
    Tag.stub!(:destroy_unused)
    Menu.stub!(:find).with('1').and_return(@menu = mock_model(Menu, :destroy => true))
  end
  
  it "should find a menu" do
    Menu.find('1').should == @menu
  end
  
  it "should redirect to menus path" do
    post :destroy, :id => 1
    controller.should redirect_to(menus_path)  
  end
  
  it "should assign value to flash[:notice]" do
    post :destroy, :id => 1
    flash[:notice].should_not be_nil
  end
end

# test de edit
describe MenusController, "edit" do
  
  it "should not edit a menu unless login" do
    Menu.stub!(:find).with('1').and_return(@menu = mock_model(Menu))
    get :edit, :id => 1
    controller.should redirect_to(home_path)  
  end

  it "should not work except for the owner" do
    controller.stub!(:current_user).and_return(mock_model(User, :id => 123))
    Menu.stub!(:find).with('1').and_return(mock_model(Menu, :user_id => 456))
    controller.stub!(:admin?).and_return(false)
    get :edit, :id => 1
    controller.should redirect_to(home_path)  
    
    Menu.stub!(:find).with('1').and_return(mock_model(Menu, :user_id => 123))
    get :edit, :id => 1
    controller.should_not redirect_to(home_path)  
  end

  it "should not work except for admin" do
    controller.stub!(:current_user).and_return(@user = mock_model(User, :id => 123))
    Menu.stub!(:find).with('1').and_return(@menu = mock_model(Menu, :user_id => 456))
    controller.stub!(:admin?).and_return(true)
    
    get :edit, :id => 1
    controller.should_not redirect_to(home_path)  
  end
end

# test de update
describe MenusController, "POST menus/:id" do
  before(:each) do
    controller.stub!(:authorize).and_return(true)
    controller.stub!(:genereTags).and_return(true)
    Tag.stub!(:destroy_unused)
  end
  
  describe "with valid arguments" do
    before(:each) do
      Menu.stub!(:find).with('1').and_return(@menu = mock_model(Menu, :update_attributes => true))
      @menu.should_receive(:date=)
    end
  
    it "should find a menu an return object" do
      post :update, :id => 1, :menu => {}
    end
  
    it "should update the menu object's attributes" do
      post :update, :id => '1', :menu => {}
    end
  
    it "should have a flash notice" do
      post :update, :id => "1", :menu => {}
      flash[:notice].should_not be_blank
    end
    
    it "should redirect to the menu's show page" do
      post :update, :id => "1", :menu => {}
      response.should redirect_to(menu_url(@menu))
    end
  end
  
  describe "with invalid arguments" do
    before(:each) do        
        Menu.stub!(:find).with("1").and_return(@menu = mock_model(Menu, :update_attributes => false))
        @menu.should_receive(:date=)        
    end
    
    it "should find menu and return object" do
        Menu.should_receive(:find).with("1").and_return(@menu)
        post :update, :id => "1", :menu => {}
    end

    it "should update the menu object's attributes" do
        @menu.should_receive(:update_attributes).and_return(false)
        post :update, :id => "1", :menu => {}
    end

    it "should render the edit form" do
        post :update, :id => "1", :menu => {}
        response.should render_template(:edit)
    end
  end
end


# test de Feed
describe MenusController, "feed" do
  before(:each) do
    @menus = [ mock_model(Menu) ]
    Menu.stub!(:find).with(:all, :order => "date desc").and_return(@menus)
  end
    
  it "should render to feed" do
    get :feed
    response.should render_template(:feed)
  end

  it "should assign menus" do
    get :feed
    assigns[:menus].should == @menus
  end
end

# test de index
describe MenusController, "index" do
  it "should render list" do
    controller.stub!(:list)
    get :index
    response.should render_template(:list)
  end
end


# test de list
describe MenusController, "list" do
  before(:each) do
    Menu.stub!(:presentation).and_return( { :affichage => 'liste_style', :items_per_page => 20})
    Menu.stub!(:paginate)
  end
  
  it "should render list" do
    get :list
    response.should render_template(:list)
  end
end




