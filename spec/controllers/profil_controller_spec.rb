require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


# test de edit
describe ProfilController, "GET /profil/edit" do  
  before(:each) do
    controller.stub!(:current_user).and_return(mock_model(User, :id => "1"))
    controller.stub!(:week_array)
  end
       
  describe "with existing profil" do
    before(:each) do
      Profil.stub!(:find_by_id).with('1').and_return(@profil = mock_model(Profil, :save=>false))
    end
    
    it "should find a profil" do
      get :edit
      assigns[:profil].should == @profil
    end
        
    it "should render edit template" do
      get :edit
      controller.should render_template(:edit)
    end
  end

  describe "with no profil" do
    before(:each) do
      Profil.stub!(:find_by_id).with('1').and_return(nil)
      Profil.stub!(:new).and_return(@profil = mock_model(User, :id => "1"))
      @profil.should_receive(:id=).with(@profil.id)
      @profil.should_receive(:user_id=).with(@profil.id)
      @profil.should_receive(:layout_name=).with(:user_style)
      @profil.should_receive(:style_menu=).with('semaine_style')
    end
    
    it "should create on" do
      @profil.should_receive(:save).and_return(true)
      get :edit
      assigns[:profil].should == @profil
    end

    it "failed to save should return to home with message" do
      @profil.should_receive(:save).and_return(false)
      get :edit
      assigns[:profil].should == @profil
      flash[:error].should_not be_nil
    end
        
    it "should render edit template" do
      @profil.should_receive(:save).and_return(true)
      get :edit
      controller.should render_template(:edit)
    end
  end
  
# test de update
describe ProfilController, "POST /profil" do
    before(:each) do
      controller.stub!(:authorize).and_return(true)
    end

    describe "with valid arguments" do
      before(:each) do
        Profil.stub!(:find_by_id).with('1').and_return(@profil = mock_model(Profil, :update_attributes => true))
      end

      it "should find a menu an return object" do
        post :update, :id => 1, :profil => {}
        assigns[:profil].should == @profil
      end

      it "should have a flash notice" do
        post :update, :id => "1", :profil => {}
        flash[:notice].should_not be_blank
      end

      it "should redirect to the menu's show page" do
        post :update, :id => "1", :profil => {}
        response.should redirect_to(home_path)
      end
    end

    describe "with invalid arguments" do
      before(:each) do        
        Profil.stub!(:find_by_id).with('1').and_return(@profil = mock_model(Profil, :update_attributes => false))
      end

      it "should have a flash notice" do
        post :update, :id => "1", :profil => {}
        flash[:notice].should be_blank
      end

      it "should render the edit form" do
        post :update, :id => "1", :profil => {}
        response.should redirect_to(home_path)
      end
    end
  end
end
