desc 'Create an admin user and roles for development environment'

task :admin_user => :environment do |t, args|
  u = User.new({:email => "admin@example.org", :password => "admin123", :password_confirmation => "admin123" })
  u.save
end

