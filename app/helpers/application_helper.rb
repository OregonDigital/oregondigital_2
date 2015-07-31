module ApplicationHelper
  include Blacklight::BlacklightHelperBehavior

  def render_document_show_field_label *args
    super.html_safe
  end
end
