module Mdls
  module Helpers
    
    class Week
    
      def initialize(current_user)
        @current_user = current_user
        @weekCode = %w( lundi mardi mercredi jeudi vendredi samedi dimanche)                
        @weekCode.each { |x| @week ||= []; @week << I18n.t(x) }
      end
      
      def week
        profil = Profil.find_by_id(@current_user.id) if @current_user 
        day = Profil.find_by_id(@current_user.id).first_day if profil
        w2 = @week.slice!(0, @weekCode.index(day)) if @weekCode.index(day)            
        @week << w2 if w2
        @week  
      end
      
      def weekAll
        weekA = @week
        weekA.unshift(I18n.t('tous'))
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