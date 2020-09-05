#! /bin/sh
RAILS_ENV=development rake db:migrate
RAILS_ENV=development rake jetty:clean
RAILS_ENV=development rake jetty:config
RAILS_ENV=development rake jetty:start
RAILS_ENV=development rake admin_user
rails s -p 3000 -b '0.0.0.0'
