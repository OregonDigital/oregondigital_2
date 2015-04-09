require_relative 'derivative_injector'
module OregonDigital
  class Injector
    attr_writer :id_service

    def id_service
      @id_service ||= ActiveFedora::Noid::Service.new
    end
  end
end
