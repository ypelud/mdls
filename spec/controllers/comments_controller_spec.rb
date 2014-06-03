require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de show
describe CommentsController, "show" do  
  before(:each) do
    @cmts = [ mock_model(Comment) ]
    Comment.stub!(:find).with(:all).and_return(@cmts)
    Comment.stub!(:find).with("1").and_return(@cmts.first)

  end

  it "should find comments" do
    find = Comment.find(:all)
    find.should == @cmts
  end
  
  it "should find first comment" do
    find = Comment.find("1")
    find.should == @cmts.first
  end
  
  it "should render to show" do
    get :show, :id => 1
    response.should render_template(:show)
  end

  it "should assign comments" do
    get :show, :id => 1
    assigns[:comment].should == @cmts.first
  end
end

# test de New
describe CommentsController, "new" do
  before(:each) do    
    
    Menu.stub!(:find).and_return(@menu = mock_model(Menu, :user_id => 1))
    Comment.stub!(:new).and_return(@cmt = mock_model(Comment, :save=>false))
  end
  
  describe 'with user connected' do
    before(:each) do    
      controller.stub!(:current_user).and_return(mock_model(User, :id => 1))
      @cmt.should_receive(:user_id=)
      @cmt.should_receive(:created_at=)
      @menu.should_receive(:comments).and_return([])
    end
  
    it "should render new template" do
      get :new
      controller.should render_template("comments/_show")
    end

    it "should create a new comment" do
      get :new
      assigns[:comment].should == @cmt
    end
  end
  
  describe 'without user connected' do
    before(:each) do    
      controller.stub!(:current_user).and_return(nil)
    end
    
    
    it "should not render new if no current_user" do
      controller.stub!(:current_user).and_return(nil)
      get :new
      response.should redirect_to(home_path)
    end
  end
end


# test de List
describe CommentsController, "list5" do
  before(:each) do      
    #.with(:all, :order, :limit)  
    Comment.stub!(:find).and_return(@comment = mock_model(Comment))
  end
  
  it "should render _list5 partial template" do
    get :list5
    controller.should render_template('comments/_list5')
  end

  it "should find a comment" do
    get :list5 
    assigns[:comments].should == @comment
  end
end
