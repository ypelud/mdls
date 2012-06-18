require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class DummyClass
end

describe "MdlsSystem" do
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(MdlsSystem)
  end

  # it "should return midi/soir" do
  #     @dummy_class.midisoir.should == ["midi", "soir"]  
  #   end
  #   
  #   it "should return week" do
  #     @dummy_class.week.should == ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]  
  #   end

  it "should handle week_array with no current user" do
    @dummy_class.stub!(:current_user).and_return(nil) #@user = mock_model(User, { :id => 1 }))
    @dummy_class.week_array
    @dummy_class.week.should == ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]  
    @dummy_class.midisoir.should == ["midi", "soir"]  
  end
  
  it "should handle week_array with no current user" do
    @dummy_class.stub!(:current_user).and_return(@user = mock_model(User, { :id => 1 }))
    Profil.stub!(:find_by_id).and_return(@profil = mock_model(Profil, { :first_day => "mercredi"}))
    @dummy_class.week_array
    @dummy_class.week.should == ["mercredi", "jeudi", "vendredi", "samedi", "dimanche","lundi", "mardi"]  
    @dummy_class.midisoir.should == ["midi", "soir"]  
  end
  
end