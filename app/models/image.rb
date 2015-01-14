class Image < GenericAsset
  contains "thumbnail", :class_name => 'FileContent'
  delegate :has_thumbnail, :has_thumbnail=, :has_medium, :has_medium=, :to => :workflow_metadata, :allow_nil => true
  delegate :thumbnail_path, :thumbnail_path=, :medium_path, :medium_path=, :to => :workflow_metadata

  private

  def derivative_class
    OregonDigital::Derivatives::ImageDerivativeGenerator
  end

  def derivative_creator
    derivative_class.new(self, content, injector.thumbnail_path(id), injector.medium_path(id))
  end

  def injector
    @injector ||= OregonDigital.inject
  end
end
