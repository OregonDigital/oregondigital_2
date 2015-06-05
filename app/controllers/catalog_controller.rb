# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController
  before_filter :redirect301, :only => :show

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior
  include Hydra::Controller::SearchBuilder
  # This applies appropriate access controls to all solr queries
  self.search_params_logic += [:add_access_controls_to_solr_params]

  def blacklight_config
    @blacklight_config ||= BlacklightConfig.new(GenericAsset, self.class.blacklight_config).configuration
  end

  def redirect301
    id = RecordID.new(params[:id])
    if id.old?
      redirect_to catalog_path(:id => id.value), :status => 301
    end
  end

end
