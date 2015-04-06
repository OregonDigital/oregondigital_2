require 'rspec/core'
require 'rspec/core/rake_task'

require 'jettywrapper'

desc "Block waiting for Jetty and then run specs"

task :ci do
  Jettywrapper.new(Jettywrapper.load_config).startup_wait!
  Rake::Task['spec'].invoke
end
