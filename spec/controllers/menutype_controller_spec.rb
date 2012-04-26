require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de index
describe MenutypeController, "index" do
  it "should render list if user admin" do
    controller.stub!(:admin?).and_return(true)
    controller.stub!(:list)
    get :index
    response.should render_template(:list)
  end

  it "should redirect if not admin" do
    controller.stub!(:list)
    get :index
    controller.should redirect_to(home_path) 
  end
end


# test de list
describe MenutypeController, "list" do
  before(:each) do
    Menutype.stub!(:presentation).and_return( { :affichage => 'liste_style', :items_per_page => 20})
    Menutype.stub!(:paginate)
  end
  
  it "should render list" do
    controller.stub!(:admin?).and_return(true)
    get :list
    response.should render_template(:list)
  end

  it "should redirect if not admin" do
    get :list
    controller.should redirect_to(home_path) 
  end

end


# test de show
describe MenutypeController, "show" do  
  before(:each) do
    controller.stub!(:admin?).and_return(true)
    Menutype.stub!(:find).with('1').and_return(@menutype = mock_model(Menutype, :save=>false))
  end
        
  it "should find a menutype" do
    Menutype.should_receive(:find).with('1').and_return(@menu)
    get :show, :id => 1
  end
        
  it "should render show template" do
    get :show, :id => 1
    controller.should render_template(:show)
  end
            
  it "should assign menu" do
    get :show, :id => 1
    assigns[:menutype].should == @menutype
  end
  
  it "should redirect if not admin" do
    controller.stub!(:admin?).and_return(false)
    get :show, :id => 1
    response.should redirect_to(home_path)
  end
end


# test de New
describe MenutypeController, "new" do
  before(:each) do    
    controller.stub!(:admin?).and_return(true)
    Menutype.stub!(:new).and_return(@menutype = mock_model(Menutype, :save=>false))    
  end
    
  it "should render show template" do
    get :new
    controller.should render_template(:new)
  end

  it "should create a new Menu" do
    get :new
    assigns[:menutype].should == @menutype
  end
  
  it "should not render new if not admin" do
    controller.stub!(:admin?).and_return(false)
    get :new
    response.should redirect_to(home_path)
  end
end

# test de Create
describe MenutypeController, "POST Create" do
  before(:each) do
    controller.stub!(:admin?).and_return(true)
    Menutype.stub!(:new).and_return(@menutype = mock_model(Menutype))
  end

  describe 'with save succeed'  do
    before(:each) do   
      @menutype.should_receive(:save).and_return(true)
    end
    
    it "should redirect to menutype_path" do
      post :create, :menutype => {  }
      controller.should redirect_to('menutype/list')  
    end
  
    it "should assign value to flash[:notice]" do
      post :create, :menutype => {  }
      flash[:notice].should_not be_nil
    end

  end

  describe  "with save failed" do
    before(:each) do    
      @menutype.should_receive(:save).and_return(false)
    end
      
    it "should render create template" do
      post :create, :menutype => { }
      controller.should render_template(:new) 
    end
  end
end

# test de edit
describe MenutypeController, "edit" do
  
  it "should not edit a menutype unless admin" do
    controller.stub!(:admin?).and_return(false)
    get :edit, :id => 1
    controller.should redirect_to(home_path)  
  end
  
  it "should edit a menutype if admin" do
    controller.stub!(:admin?).and_return(true)
    Menutype.stub!(:find).with('1').and_return(@menutype = mock_model(Menutype, :save=>false))
    get :edit, :id => 1
    controller.should render_template(:edit) 
  end
end

# test de update
describe MenutypeController, "POST menutype/:id" do
  before(:each) do
    controller.stub!(:admin?).and_return(true)
  end
  
  describe "with valid arguments" do
    before(:each) do
      Menutype.stub!(:find).with('1').and_return(@menutype = mock_model(Menutype, :update_attributes => true))
    end
  
    it "should find a menutype an return object" do
      Menutype.should_receive(:find).with('1').and_return(@menutype)
      post :update, :id => 1, :menutype => {}
    end
  
    it "should update the menutype object's attributes" do
      @menutype.should_receive(:update_attributes).and_return(true)
      post :update, :id => '1', :menutype => {}
    end
  
    it "should have a flash notice" do
      post :update, :id => "1", :menutype => {}
      flash[:notice].should_not be_blank
    end
    
    it "should redirect to the menutype's show page" do
      post :update, :id => "1", :menu => {}
      response.should redirect_to(menutype_url(@menutype))
    end
  end
  
  describe "with invalid arguments" do
    before(:each) do        
        Menutype.stub!(:find).with('1').and_return(@menutype = mock_model(Menutype, :update_attributes => false)) 
    end
    
    it "should find menutype and return object" do
        Menutype.should_receive(:find).with("1").and_return(@menutype)
        post :update, :id => "1", :menutype => {}
    end

    it "should update the menutype object's attributes" do
        @menutype.should_receive(:update_attributes).and_return(false)
        post :update, :id => "1", :menutype => {}
    end

    it "should render the edit form" do
        post :update, :id => "1", :menutype => {}
        response.should render_template(:edit)
    end
  end
end

# test de destroy
describe MenutypeController, "destroy" do
  before(:each) do
    controller.stub!(:admin?).and_return(true)
    Menutype.stub!(:find).with('1').and_return(@menutype = mock_model(Menutype, :destroy => true))
  end
  
  it "should find a menutype" do
    Menutype.find('1').should == @menutype
  end
  
  it "should redirect to menutype path" do
    post :destroy, :id => 1
    controller.should redirect_to(menutype_path)  
  end
  
  it "should assign value to flash[:notice]" do
    post :destroy, :id => 1
    flash[:notice].should_not be_nil
  end
end
