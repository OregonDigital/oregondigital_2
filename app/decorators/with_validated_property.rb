class WithValidatedProperty < SimpleDelegator
  attr_reader :property, :validator
  def initialize(resource, property, validator)
    super(resource)
    @property = property
    @validator = validator
  end

  def valid?(*args)
    __getobj__.valid?(*args)
    unless validator.valid?(result)
      errors.add(property, validator.message)
    end
    errors.blank?
  end

  def save(*args)
    return false unless valid?
    __getobj__.save(*args)
  end

  private

  def result
    get_values(property, :cast => false)
  end
end
