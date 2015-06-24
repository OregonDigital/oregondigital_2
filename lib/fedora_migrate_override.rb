module FedoraMigrate
  class TargetConstructor
    def vet model
      possible_target = FedoraMigrate::Mover.id_component(model)
      if possible_target == "GenericCollection"
        possible_target = "GenericSet"
      end
        @target = possible_target.constantize
    rescue NameError
      Logger.debug "rejecting #{model} for target"
    end
  end
end

