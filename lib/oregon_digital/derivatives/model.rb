module OregonDigital::Derivatives
  module Model
    extend ActiveSupport::Concern

    included do
      before_save :check_derivatives
      after_save :create_derivatives, :if => :needs_derivatives?
    end

    def check_derivatives
      @needs_derivatives = true if content.content_changed? && !content.content.blank?
      true
    end

    def create_derivatives
      @needs_derivatives = false
      begin
        derivative_creator.run
      rescue NotImplementedError
      end
    end

    def derivative_creator
      derivative_class.new(self, content)
    end

    def derivative_class
      raise NotImplementedError
    end

    def needs_derivatives?
      @needs_derivatives
    end

    module ClassMethods
      def has_derivatives(*derivatives)
        derivatives.each do |derivative|
          delegate :"has_#{derivative}", :"has_#{derivative}=", :to => :workflow_metadata, :allow_nil => true
          delegate :"#{derivative}_path", :"#{derivative}_path=", :to => :workflow_metadata, :allow_nil => true
        end
      end
    end
  end
end
