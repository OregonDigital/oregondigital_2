class ValidatedAssetRepository
  pattr_initialize :base_repository

  def new(*args)
    decorate(base_repository.new(*args))
  end

  def find(*args)
    decorate(base_repository.find(*args))
  end

  def decorate(asset)
    property_decorator.new(
      asset,
      validations
    ).run
  end

  private

  def property_decorator
    DecorateProperties
  end

  def validations
    @validations ||= 
      PropertyValidationsGenerator.new(base_repository).validations
  end
end
