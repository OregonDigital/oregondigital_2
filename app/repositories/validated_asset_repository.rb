class ValidatedAssetRepository
  pattr_initialize :base_repository

  def new(*args)
    property_decorator.new(
      base_repository.new(*args),
      validations
    ).run
  end

  def find(*args)
    property_decorator.new(
      base_repository.find(*args),
      validations
    ).run
  end

  private

  def property_decorator
    DecorateProperties
  end

  def validations
    {
      :lcsubject => [
        SubjectCvValidator.new
      ]
    }
  end
end
