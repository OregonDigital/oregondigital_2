class Image < GenericAsset
  contains "thumbnail", :class_name => 'FileContent'
  delegate :has_thumbnail, :has_medium, :to => :workflow_metadata, :allow_nil => true
  delegate :has_medium=, :has_thumbnail=, :to => :workflow_metadata

  private

  def derivative_class
    OregonDigital::Derivatives::ImageDerivativeGenerator
  end
end
