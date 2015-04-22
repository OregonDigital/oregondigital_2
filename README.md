OregonDigital\_2
===============

[![Circle CI](https://circleci.com/gh/OregonDigital/oregondigital_2.svg?style=svg)](https://circleci.com/gh/OregonDigital/oregondigital\_2)


Local Development Setup
-----

Requirements:

**Ruby Version: 2.0**

Configuration and database creation:

    git clone git@github.com:OregonDigital/oregondigital_2.git
	cd oregondigital_2
	bundle install
	rake db:migrate
	rake jetty:clean
	rake jetty:config

Note: To prevent errors, you may need to prefix the rake commands with `bundle exec`, which can be required in some systems. 

Start the servers:

    rake jetty:start
	rails server

You can go to your browser and open `http://localhost:3000`, where you can see the Rails app running. When you access `http://localhost:8983` Jetty should list the available contexts (solr and fedora)

Run tests with RSpec:

    rspec spec
