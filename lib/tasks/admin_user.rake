desc 'Create an admin user and roles for development environment'

task :admin_user => :environment do |t, args|
  user = User.find_or_create_by(:email => "admin@example.org") do |u|
    u.password = "admin123"
    u.password_confirmation = "admin123"
  end

  admin = Role.find_or_create_by(:name => "admin")
  user.roles = [admin]
  user.save!
end

