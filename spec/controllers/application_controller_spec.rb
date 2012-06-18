require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# def authorize
describe ApplicationController, "authorize?" do  
  it "for admin shoul return true" do
    controller.stub!(:admin?).and_return(true)
    controller.stub!(:respond_to?).with(:user_ok?,true).and_return(false)
    
    controller.send(:authorize).should be_nil
  end

end
