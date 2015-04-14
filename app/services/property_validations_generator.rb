class PropertyValidationsGenerator
  pattr_initialize :base_repository
  def validations
    {
      :lcsubject => [
        SubjectCvValidator.new
      ]
    }
  end
end
