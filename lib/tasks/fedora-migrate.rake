include 'fedora_migrate_override.rb'

desc "Migrate all my objects"
task migrate: :environment do
  puts "Migrating repository from fedora3 to fedora4"
  FedoraMigrate.migrate_repository(namespace: "oregondigital", options: {convert: "descMetadata"})
  puts "Migration successful"
  puts "Fixing bad sets"
  bad_ids = ActiveFedora::SolrService.query("set_ssim:#{RSolr.solr_escape("http://oregondigital.org/resource")}*", :fl => :id, :rows => 10000).map{|x| x["id"]}
  bad_ids.each do |id|
    asset = GenericAsset.find(id)
    asset.set = asset.set_ids.map{|x| RDF::URI(ActiveFedora::Base.id_to_uri(ActiveFedora::Base.uri_to_id(x.to_s).split(":").last))}
    asset.save
  end
  puts "Bad sets fixed"
  puts "Exiting"
end 
