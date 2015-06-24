# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior
  include Hydra::Controller::SearchBuilder
  # This applies appropriate access controls to all solr queries
  # self.search_params_logic += [:add_access_controls_to_solr_params]

  def blacklight_config
    @blacklight_config ||= config_builder.configuration
  end

  def config_builder
    @config_builder ||= BlacklightConfig.new(GenericAsset, self.class.blacklight_config)
  end
end
