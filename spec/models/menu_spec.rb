require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Menu do
  
  before(:each) do
    @menu = Menu.new
  end

  it "should be valid" do
    @menu.should be_valid
  end
   
  it "should return presentation" do
    pres = Menu.presentation('1')
    pres[:affichage].should == 'liste_style'
    pres[:items_per_page].should == Menu.per_page
  end
  
  it "should regenerate tags" do
    @menu.title = "un deux trois quatre"
    @menu.menutype_id = 1
    @menu.user_id = 1
    @menu.save!()
    @menu.tag_list.count.should == 3
    @menu.tag_list[0].should == "deux"
    @menu.tag_list[1].should == "trois"
    @menu.tag_list[2].should == "quatre"
  end
end