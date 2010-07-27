module Mdls
  module Helpers
    
    class Week
    
      def initialize(current_user)
        @current_user = current_user
        @week = I18n.t('lundi'), I18n.t('mardi'), I18n.t('mercredi'), I18n.t('jeudi'), I18n.t('vendredi'), I18n.t('samedi'), I18n.t('dimanche')
      end
      
      def week
        if @current_user and Profil.find_by_id(@current_user.id) 
          day = Profil.find_by_id(@current_user.id).first_day
          deb = @week[0]
          while day and @week[0]!=day do
            dec = @week[0] 
            @week.shift
            @week.push(dec) 
            break if @week[0]==deb 
          end          
        end          
        @week  
      end
    
      def self.included(base)
        base.send :helper_method, :week_array if base.respond_to? :helper_method
      end
    
      #méthodes pour les gestions du temps
      def midisoir
        md = t("mdls.midi"),t("mdls.soir")  
        return md
      end 
    
    end

  end
end