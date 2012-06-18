require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# test de New
describe UsersController, "new" do
  before(:each) do    
    User.stub!(:new).and_return(@user = mock_model(User, :save=>false))
  end
    
  it "should render show template" do
    get :new
    controller.should render_template(:new)
  end

  it "should create a new Menu" do
    get :new
    assigns[:user].should == @user
  end
end

# test de edit
describe UsersController, "POST /create" do  
  fixtures :users
  
  before :each do
    UserMailer.stub!(:deliver_signup_notification)
  end

  it 'should allow signup' do
    post :create, :user => { :login => 'test', :email => 'test@example.com', :password => 'test', :password_confirmation => 'test' }
    response.should redirect_to(home_path)
  end

  it "should require login on signup" do
    post :create, :user => { :login => nil, :email => 'test@example.com', :password => 'test', :password_confirmation => 'test' }
    assigns(:user).errors.on(:login).should_not be_nil
  end

  it "should require password on signup" do
    post :create, :user => { :login => 'test', :email => 'test@example.com', :password => nil, :password_confirmation => "test" }
    assigns(:user).errors.on(:password).should_not be_nil
  end

  it "should require password confirmation on signup" do
    post :create, :user => { :login => 'test', :email => 'test@example.com', :password => "test", :password_confirmation => nil }
    assigns(:user).errors.on(:password_confirmation).should_not be_nil
  end

  it "should require email on signup" do
    post :create, :user => { :login => 'test', :email => nil, :password => "test", :password_confirmation => "test" }
    assigns(:user).errors.on(:email).should_not be_nil
  end

  it "should sign up user with activation code" do
    post :create, :user => { :login => 'test', :email => 'test@example.com', :password => 'test', :password_confirmation => 'test' }
    assigns(:user).reload
    assigns(:user).activation_code.should_not be_nil
  end

end

describe UsersController, "GET /activate" do  
  fixtures :users
  
  before :each do
    UserMailer.stub!(:deliver_activation)
  end


  it "should activate user" do
    User.authenticate('aaron', 'test').should be_nil
    get :activate, :activation_code => users(:aaron).activation_code
    response.should redirect_to(home_path)
    flash[:notice].should_not be_nil
    users(:aaron).should == User.authenticate('aaron', 'test')
  end
  
  it "should not activate user without key" do
      get :activate
      flash[:notice].should be_nil
  end
    
  it "should not activate user with blank key" do
    get :activate, :activation_code => ''
    flash[:notice].should be_nil
  end
  
end


describe UsersController, "POST /forgot" do  
  fixtures :users
  
  before :each do
    UserMailer.stub!(:deliver_reset_notification)
  end


  it "should create reset code for user" do
    User.stub!(:find_by_email).and_return(@user = users(:aaron))
    post :forgot, :user => { :email => @user.email }
    response.should redirect_to(home_path)
    flash[:notice].should_not be_nil
    @user.reset_code.should_not be_nil
  end

  it "should not create reset code for nil" do
    User.stub!(:find_by_email).and_return(nil)
    post :forgot, :user => { :email => "user.email" }
    response.should redirect_to(home_path)
    flash[:error].should_not be_nil
  end
  
end

describe UsersController, "POST /reset" do  
  fixtures :users
  
  before :each do
    UserMailer.stub!(:deliver_activation)
  end


  it "should reset for user" do
    User.stub!(:find_by_reset_code).and_return(@user = users(:aaron))
    post :reset, :reset_code => "", :user => {  :password => "test", :password_confirmation => "test" }
    response.should redirect_to(home_path)
    flash[:notice].should_not be_nil
    @user.reset_code.should be_nil
  end
  
  it "should reset for user and return errors if failed" do
    User.stub!(:find_by_reset_code).and_return(@user = users(:aaron))
    @user.should_receive(:update_attributes).and_return(false)
    post :reset, :reset_code => "", :user => {  :password => "test", :password_confirmation => "test" }
    controller.should render_template(:errors) 
    response.layout.should == "layouts/simple"
    #rails 3 controller.should render_template("layouts/simple") 
  end
  
  it "should not reset code for nil" do
    User.stub!(:find_by_reset_code).and_return(nil)
    post :reset, :reset_code => "", :user => {  :password => "test", :password_confirmation => "test" }
    response.should redirect_to(home_path)
  end
  
end


describe UsersController, "GET /language" do  
  fixtures :users
  
  before :each do
      request.env["HTTP_REFERER"] = "/where_i_came_from"
  end


  it "should put language to en-US" do
    post :language, :code => "en-US"
    response.should redirect_to "where_i_came_from"
    session[:language].should == "en-US"
  end

  it "should put language to default fr-FR" do
    post :language, :code => nil
    response.should redirect_to "where_i_came_from"
    session[:language].should == "fr-FR"
  end
    
end

# test de index
describe UsersController, "Get /index" do
  before(:each) do
    User.stub!(:paginate).and_return(@users = [])
  end
  
  it "should render index if admin" do
    controller.stub!(:admin?).and_return(true)
    get :index
    response.should render_template(:index)
    assigns[:users].should == @users
  end
end


