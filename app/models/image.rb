class Image < GenericAsset
  [:thumbnail, :medium, :pyramidal].each do |derivative|
    delegate :"has_#{derivative}", :"has_#{derivative}=", :to => :workflow_metadata, :allow_nil => true
    delegate :"#{derivative}_path", :"#{derivative}_path=", :to => :workflow_metadata, :allow_nil => true
  end

  private

  def derivative_class
    OregonDigital::Derivatives::Generators::ImageDerivativeGenerator
  end

  def derivative_creator
    derivative_class.new(self, content, injector.thumbnail_runner(id), injector.medium_runner(id), injector.pyramidal_runner(id))
  end

  def injector
    @injector ||= OregonDigital.inject
  end
end
