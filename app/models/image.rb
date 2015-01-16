class Image < GenericAsset
  contains "thumbnail", :class_name => 'FileContent'
  [:thumbnail, :medium, :pyramidal].each do |derivative|
    delegate :"has_#{derivative}", :"has_#{derivative}=", :to => :workflow_metadata, :allow_nil => true
    delegate :"#{derivative}_path", :"#{derivative}_path=", :to => :workflow_metadata, :allow_nil => true
  end

  private

  def derivative_class
    OregonDigital::Derivatives::Generators::ImageDerivativeGenerator
  end

  def derivative_creator
    derivative_class.new(self, content, injector.thumbnail_path(id), injector.medium_path(id), injector.pyramidal_path(id))
  end

  def injector
    @injector ||= OregonDigital.inject
  end
end
