require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de show
describe PlanningsController, "show" do  
  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User, :login => "user"))
    Planning.stub!(:find).with('1').and_return(@planning = mock_model(Planning, :save=>false))
  end
        
  it "should find a planning" do
    Planning.should_receive(:find).with('1').and_return(@planning)
    get :show, :id => 1
  end
        
  it "should render show template" do
    get :show, :id => 1
    controller.should render_template(:show)
  end
            
  it "should assign planning" do
    get :show, :id => 1
    assigns[:planning].should == @planning
  end
  
  it "should render show if no current_user" do
    controller.stub!(:current_user).and_return(nil)
    get :show, :id => 1
    response.should_not redirect_to(home_path)
  end
end


# test de New
describe PlanningsController, "new" do
  before(:each) do    
    controller.stub!(:current_user).and_return(mock_model(User, :login => "user"))
    Planning.stub!(:new).and_return(@planning = mock_model(Planning, :save=>false))
  end
    
  it "should render new template" do
    get :new
    controller.should render_template(:new)
  end

  it "should create a new planning" do
    get :new
    assigns[:planning].should == @planning
  end
  
  it "should not render new if no current_user" do
    controller.stub!(:current_user).and_return(nil)
    get :new
    response.should redirect_to(home_path)
  end
end


# test de Create
describe PlanningsController, "POST Create" do
  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User, :login => "test"))
    Time.stub!(:new)
    Planning.stub!(:new).and_return(@planning = mock_model(Planning))
    @planning.should_receive(:user_id=)
    session[:choix] = [@menusliste = mock_model(Menusliste)]
  end

  describe 'with save succeed'  do
    before(:each) do   
      @planning.should_receive(:save!).and_return(true)
      @menusliste.should_receive(:save!).and_return(true)
      @menusliste.should_receive(:planning=).with(@planning)
    end
    
    it "should redirect to plannings_path" do
      post :create, :planning => {  }
      controller.should redirect_to(plannings_path)  
    end
  
    it "should assign value to flash[:notice]" do
      post :create, :planning => {  }
      flash[:notice].should_not be_nil
    end    
  end

  # describe  "with save failed" do
  #   before(:each) do    
  #     @planning.should_receive(:save!).and_raise(ActiveRecord::StatementInvalid)
  #   end
  #     
  #   it "should render create template" do
  #     post :create, :planning => { }
  #     controller.should render_template(:new) 
  #   end
  # end
end
# 
# #test de recupere
# describe PlanningsController, "recupere" do
#   before(:each) do
#     planning.stub!(:tag_counts).and_return(@tags = "test")
#   end
#     
#   it "should render partial " do
#     get :recupere
#     controller.should render_template(:tags_list) 
#   end
# 
#   it "should assign @tags " do
#     get :recupere
#     assigns[:tags].should == @tags
#   end
# 
# end
# 
# # test de Feedurl
# describe PlanningsController, "feedurl" do
#   it "should redirect to feedurl" do
#     get :feedurl
#     response.should redirect_to('http://feeds2.feedburner.com/planningsdelasemaine')
#   end
# end
# 
# # test de destroy
# describe PlanningsController, "destroy" do
#   before(:each) do
#     controller.stub!(:authorize_user).and_return(true)
#     Tag.stub!(:destroy_unused)
#     planning.stub!(:find).with('1').and_return(@planning = mock_model(Planning, :destroy => true))
#   end
#   
#   it "should find a planning" do
#     planning.find('1').should == @planning
#   end
#   
#   it "should redirect to plannings path" do
#     post :destroy, :id => 1
#     controller.should redirect_to(plannings_path)  
#   end
#   
#   it "should assign value to flash[:notice]" do
#     post :destroy, :id => 1
#     flash[:notice].should_not be_nil
#   end
# end
# 
# # test de edit
# describe PlanningsController, "edit" do
#   
#   it "should not edit a planning unless login" do
#     planning.stub!(:find).with('1').and_return(@planning = mock_model(Planning))
#     get :edit, :id => 1
#     controller.should redirect_to(home_path)  
#   end
# 
#   it "should not work except for the owner" do
#     controller.stub!(:current_user).and_return(mock_model(User, :id => 123))
#     planning.stub!(:find).with('1').and_return(mock_model(planning, :user_id => 456))
#     controller.stub!(:admin?).and_return(false)
#     get :edit, :id => 1
#     controller.should redirect_to(home_path)  
#     
#     planning.stub!(:find).with('1').and_return(mock_model(planning, :user_id => 123))
#     get :edit, :id => 1
#     controller.should_not redirect_to(home_path)  
#   end
# 
#   it "should not work except for admin" do
#     controller.stub!(:current_user).and_return(@user = mock_model(User, :id => 123))
#     planning.stub!(:find).with('1').and_return(@planning = mock_model(Planning, :user_id => 456))
#     controller.stub!(:admin?).and_return(true)
#     
#     get :edit, :id => 1
#     controller.should_not redirect_to(home_path)  
#   end
# end
# 
# # test de update
# describe PlanningsController, "POST plannings/:id" do
#   before(:each) do
#     controller.stub!(:authorize_user).and_return(true)
#     controller.stub!(:genereTags).and_return(true)
#     Tag.stub!(:destroy_unused)
#   end
#   
#   describe "with valid arguments" do
#     before(:each) do
#       planning.stub!(:find).with('1').and_return(@planning = mock_model(Planning, :update_attributes => true))
#       @planning.should_receive(:date=)
#     end
#   
#     it "should find a planning an return object" do
#       planning.should_receive(:find).with('1').and_return(@planning)
#       post :update, :id => 1, :planning => {}
#     end
#   
#     it "should update the planning object's attributes" do
#       @planning.should_receive(:update_attributes).and_return(true)
#       post :update, :id => '1', :planning => {}
#     end
#   
#     it "should have a flash notice" do
#       post :update, :id => "1", :planning => {}
#       flash[:notice].should_not be_blank
#     end
#     
#     it "should redirect to the planning's show page" do
#       post :update, :id => "1", :planning => {}
#       response.should redirect_to(planning_url(@planning))
#     end
#   end
#   
#   describe "with invalid arguments" do
#     before(:each) do        
#         planning.stub!(:find).with("1").and_return(@planning = mock_model(Planning, :update_attributes => false))
#         @planning.should_receive(:date=)        
#     end
#     
#     it "should find planning and return object" do
#         planning.should_receive(:find).with("1").and_return(@planning)
#         post :update, :id => "1", :planning => {}
#     end
# 
#     it "should update the planning object's attributes" do
#         @planning.should_receive(:update_attributes).and_return(false)
#         post :update, :id => "1", :planning => {}
#     end
# 
#     it "should render the edit form" do
#         post :update, :id => "1", :planning => {}
#         response.should render_template(:edit)
#     end
#   end
# end
# 
# 
# # test de Feed
# describe PlanningsController, "feed" do
#   before(:each) do
#     @plannings = [ mock_model(planning) ]
#     planning.stub!(:find).with(:all, :order => "date desc").and_return(@plannings)
#   end
#     
#   it "should render to feed" do
#     get :feed
#     response.should render_template(:feed)
#   end
# 
#   it "should assign plannings" do
#     get :feed
#     assigns[:plannings].should == @plannings
#   end
# end
# 
# # test de index
# describe PlanningsController, "index" do
#   it "should render list" do
#     controller.stub!(:list)
#     get :index
#     response.should render_template(:list)
#   end
# end
# 
# 
# # test de list
# describe PlanningsController, "list" do
#   before(:each) do
#     planning.stub!(:presentation).and_return( { :affichage => 'liste_style', :items_per_page => 20})
#     planning.stub!(:paginate)
#   end
#   
#   it "should render list" do
#     get :list
#     response.should render_template(:list)
#   end
# end
# 
# 
# 
# 
