# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'jettywrapper'

require File.expand_path('../config/application', __FILE__)

MARMOTTA_HOME = ENV['MARMOTTA_HOME'] || File.expand_path(File.join(Jettywrapper.app_root, 'jetty/marmotta'))
Jettywrapper.url = "https://github.com/OregonDigital/hydra-marmotta-jetty/archive/develop.zip"
Rails.application.load_tasks
