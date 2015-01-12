class Image < GenericAsset
  contains "thumbnail", :class_name => 'FileContent'
  delegate :has_thumbnail, :to => :workflow_metadata, :allow_nil => true

  def has_thumbnail=(value)
    workflow_metadata.has_thumbnail = value
  end

  private

  def derivative_class
    OregonDigital::Derivatives::ImageDerivativeGenerator
  end
end
