module ActiveRecord
  class Errors
    @@default_error_messages.update( {
      :inclusion => "n'est pas inclut dans la liste",
      :exclusion => "est réservé",
      :invalid => "est invalide",
      :confirmation => "ne correspond pas à la confirmation",
      :accepted => "doit être accepté",
      :empty => "ne peut pas être vide",
      :blank => "est requis",
      :too_long => "est trop long (%d caractères maximum)",
      :too_short => "est trop court(%d caractères minimum)",
      :wrong_length => "n'est pas de la bonne longueur (devrait être de %d caractères)",
      :taken => "est déjà  prit",
      :not_a_number => "n'est pas un nombre",
      
      :greater_than => "doit être plus grand que %d",
      :greater_than_or_equal_to => "doit être plus grand ou égal à %d",
      :equal_to => "doit être égal à %d",
      :less_than => "doit être inférieur à %d",
      :less_than_or_equal_to => "doit être inférieur ou égal à %d",
      :odd => "must be odd",
      :even => "must be even"
    })

    def full_messages
      full_messages = []

      @errors.each_key do |attr|
        @errors[attr].each do |msg|
          next if msg.nil?

          if attr == "base"
            full_messages << msg
          else
            full_messages << @base.class.localized_human_attribute_name(attr) + " " + msg
          end
        end
      end

      full_messages
    end
  end
    
  class Base
    class << self
      def localized_human_attribute_name(attr) #:nodoc:
        attr.humanize
      end
    end
  end
end

module ActionView #nodoc
  module Helpers
    module ActiveRecordHelper
      def error_messages_for(object_name, options = {})
        options = options.symbolize_keys
        object = instance_variable_get("@#{object_name}")

        unless object.errors.empty?
          content_tag("div",
            content_tag(
              options[:header_tag] || "h2",
              "#{pluralize(object.errors.count, "erreurs")} empêche(nt) cette forme d'être sauvegardée"
            ) +
            content_tag("p", "Veuillez vérifier les informations et apporter les modifications aux champs suivants :"
            ) +
            content_tag("ul", object.errors.full_messages.collect { |msg| content_tag("li", "Le champ " + msg) }),
            "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation"
          )
        end
      end
    end
  end
end