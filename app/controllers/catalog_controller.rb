# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController
  before_filter :redirect301, :only => :show

  include Hydra::Catalog
  include Hydra::Controller::ControllerBehavior
  # This applies appropriate access controls to all solr queries
  self.search_params_logic += [:add_access_controls_to_solr_params]
  # Apply access controls to show.
  before_filter :enforce_show_permissions, :only => :show

  def blacklight_config
    @blacklight_config ||= config_builder.configuration
  end

  def config_builder
    @config_builder ||= BlacklightConfig.new(GenericAsset, self.class.blacklight_config)
  end

  private

  def enforce_show_permissions
    permissions = current_ability.permissions_doc(params[:id])
    unless can? :read, permissions
      raise Hydra::AccessDenied.new("You do not have sufficient access privileges to read this document, which has been marked private.", :read, params[:id])
    end
  end

  def redirect301
    id = RecordID.new(params[:id])
    if id.old?
      redirect_to catalog_path(:id => id.value), :status => 301
    end
  end

end
