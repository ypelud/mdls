require 'spec_helper'

describe MenusController, "Créer un nouveau menu" do
  #integrate_views
  fixtures :menus, :users
  

  it "doit rediriger vers la page d'accueil et notifier une erreur" do
	Menu.any_instance.stubs(:valid?).returns(true)
	post 'create'
	flash[:error].should_not be_nil
	response.should redirect_to(home_path)
  end
 
  it "doir rediriger vers la liste des menus et notifier le succes" do
	@current_user = mock_model(User)
    controller.stub!(:login_required).and_return(:true)
    controller.stub!(:current_user).and_return(@current_user)
	
	#Menu.any_instance.stubs(:valid?).returns(true)
	@menu = mock_model(Menu, :menutype_id=>1, :user_id=>1)
	post 'create', :menu => @menu
	flash[:notice].should_not be_nil
	respondse.should redirect_to(home_path)
  end
   
  it "should re-render new template on failed save"

end
