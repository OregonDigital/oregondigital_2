class WithValidatedProperty < SimpleDelegator
  attr_reader :property, :validator
  def initialize(resource, property, validator)
    super(resource)
    @property = property
    @validator = validator
  end

  def valid?
    __getobj__.valid?
    unless validator.valid?(result)
      errors.add(property, validator.message)
    end
    errors.blank?
  end

  private

  def result
    get_values(property, :cast => false)
  end
end
