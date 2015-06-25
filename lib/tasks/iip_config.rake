desc 'Print out config for use with IIPImage server'

task :iip_config => :environment do |t, args|
  print "# Drop this into wherever IIPImage's conf lives; e.g., /etc/apache2/mods-available/iipsrv.conf"
  conf = IO.foreach(Rails.root.join("config/iip/iipsrv.conf")) do |line|
    line.gsub!("FSPREFIX", OregonDigital::derivative_injector.pyramidal_base.to_s)
    print line
  end
end
