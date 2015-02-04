module OregonDigital::Derivatives
  module Model
    extend ActiveSupport::Concern
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
