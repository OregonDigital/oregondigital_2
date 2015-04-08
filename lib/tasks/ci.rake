require 'rspec/core'
require 'rspec/core/rake_task'

require 'jettywrapper'

desc "Block waiting for Jetty and then run specs"

task :ci => :environment do
  Jettywrapper.new(Jettywrapper.load_config).startup_wait!
  RSpec::Core::RakeTask.new(:ci_spec) do |t|
    t.rspec_opts = "--format progress --color --format RspecJunitFormatter --out #{ENV['CIRCLE_TEST_REPORTS'] || Rails.root}/rspec/rspec.xml"
  end
  Rake::Task["ci_spec"].invoke
end
