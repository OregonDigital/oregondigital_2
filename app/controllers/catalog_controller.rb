# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior
  include Hydra::Controller::SearchBuilder
  # This applies appropriate access controls to all solr queries
  self.search_params_logic += [:add_access_controls_to_solr_params]
  # Include Oregon Digital Catalog Logic
  include OregonDigital::Catalog

  def blacklight_config
    BlacklightConfig.new(GenericAsset).configuration
  end
end
