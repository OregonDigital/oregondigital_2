#! /bin/sh
RAILS_ENV=development rake db:migrate
RAILS_ENV=development rake jetty:clean
RAILS_ENV=development rake jetty:config
RAILS_ENV=development rake jetty:start
rails s -p 3000 -b '0.0.0.0'
