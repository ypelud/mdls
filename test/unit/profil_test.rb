require File.dirname(__FILE__) + "/../test_helper"

class ProfilTest < ActiveSupport::TestCase

  fixtures :profils, :users
  
  def test_should_create_profil
    assert_difference 'Profil.count' do
      profil = create_profil
      assert !profil.new_record?, "#{profil.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_user
    assert_no_difference 'Profil.count' do
      profil = create_profil(:user => nil)
      assert profil.errors.on(:user)
    end
  end



protected 

    def create_profil(options = {})
      user = users(:quentin)      
      record = Profil.new({:layout_name => '', :style_menu => '', \
        :user => user, :first_day => ''}.merge(options))
      record.save
      record
    end
  
  
end
