class GenericAsset < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include OregonDigital::Models::Metadata
  before_save :check_derivatives
  after_save :create_derivatives, :if => :needs_derivatives?
  contains "content", :class_name => 'FileContent'
  contains "workflow_metadata", :class_name => "Files::YmlFile"

  def assign_rdf_subject
    super
  end

  private
  
  def check_derivatives
    @needs_derivatives = true if content.content_changed? && !content.content.blank?
    true
  end

  def create_derivatives
    @needs_derivatives = false
    begin
      derivative_creator.run
    rescue NotImplementedError
    end
  end

  def derivative_creator
    derivative_class.new(self, content)
  end

  def derivative_class
    raise NotImplementedError
  end

  def needs_derivatives?
    @needs_derivatives
  end

  def assign_id
    OregonDigital::IdService.mint
  end
end
