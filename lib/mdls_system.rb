module MdlsSystem

  attr_accessor :week, :midisoir
  
  def self.included(base)
    base.before_filter :week_array
  end
  # def midisoir
  #     md = I18n.t("mdls.midi"),I18n.t("mdls.soir")
  #     md
  #   end 
  #   
  #   def week
  #     w = I18n.t('lundi'), I18n.t('mardi'), I18n.t('mercredi'), I18n.t('jeudi'), I18n.t('vendredi'), I18n.t('samedi'), I18n.t('dimanche')
  #     w
  #   end 
  
  def week_array
    @week_list =  I18n.t('lundi'), I18n.t('mardi'), I18n.t('mercredi'), I18n.t('jeudi'), I18n.t('vendredi'), I18n.t('samedi'), I18n.t('dimanche')
    @week = I18n.t('lundi'), I18n.t('mardi'), I18n.t('mercredi'), I18n.t('jeudi'), I18n.t('vendredi'), I18n.t('samedi'), I18n.t('dimanche')
    if current_user and profil = Profil.find_by_id(current_user.id) 
      #profil = Profil.find_by_id(current_user.id)
      day = profil.first_day           
      deb = @week[0]
      while day and @week[0]!=day do
        dec = @week[0] 
        @week.shift
        @week.push(dec) 
        break if @week[0]==deb 
      end          
    end            
    @midisoir = I18n.t("mdls.midi"),I18n.t("mdls.soir")
  end
    
end