desc "Migrate all my objects"
task migrate: :environment do
  results = FedoraMigrate.migrate_repository(namespace: "oregondigital", options: {convert: "descMetadata"})
  binding.pry
  puts results 
end 
