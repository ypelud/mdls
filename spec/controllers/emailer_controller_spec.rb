require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de index
describe EmailerController, "sendmail" do

  it 'should send mail' do
    controller.stub!(:current_user).and_return(@user = mock_model(User, :id => 123))
    @user.should_receive(:email).and_return("test@test.test")
    @user.should_receive(:login).and_return("login_test")
    
    Emailer.stub!(:deliver_contact)
    controller.request.should_receive(:xhr?).and_return false
    get :sendmail, {:email => "dest@dest.dest", :cc_mail => 1,  :subject =>'sujet 123', :message => "message 1234"}
  end
end
