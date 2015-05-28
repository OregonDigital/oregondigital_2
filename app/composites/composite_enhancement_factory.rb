##
# A composite for Enhancement Factories.
# @example CompositeEnhancementFactory.new(LabelEnhancement,
#   AltLabelEnhancement)
class CompositeEnhancementFactory
  attr_reader :factories
  def initialize(*factories)
    @factories = factories
  end

  def new(property)
    CompositeEnhancement.new(factories, property)
  end

  class CompositeEnhancement
    pattr_initialize :factories, :property

    def property
      enhancements.map(&:property)
    end

    private

    def enhancements
      @enhancements ||= factories.map do |factory|
        factory.new(@property)
      end
    end
  end
end
