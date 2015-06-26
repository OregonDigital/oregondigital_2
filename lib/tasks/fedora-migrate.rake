desc "Migrate all my objects"
task migrate: :environment do
  puts "Migrating repository from fedora3 to fedora4"
  FedoraMigrate.migrate_repository(namespace: "oregondigital", options: {convert: "descMetadata"})
  puts "Migration successful"
  puts "Fixing bad sets"
  OregonDigital::SetFixer.new(ActiveFedora::SolrService, GenericAsset).fix_set
  puts "Bad sets fixed"
  puts "Exiting"
end 

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

