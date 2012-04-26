require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de sidebar
describe HomeController, "sidebar" do  
  it "should render _sidebar partial template" do
    get :sidebar 
    controller.should render_template('home/_sidebar')
  end
end

# test de compteur
describe HomeController, "compteur" do  
  before :each do
    User.stub!(:count).and_return(99)
    Menu.stub!(:count).and_return(999)
  end
  
  it "should render _sidebar partial template" do
    get :compteur
    controller.should render_template('home/_compteur')
  end
  
  it "should count 99 users" do
    get :compteur
    assigns[:nbM].should == 99
  end


  it "should count 999 menus" do
    get :compteur
    assigns[:nbC].should == 999
  end
end

# test de comment
describe HomeController, "comment" do  
  it "should render comment template" do
    get :comment
    controller.should render_template('home/comment')
  end
end