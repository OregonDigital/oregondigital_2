OregonDigital\_2
===============

[![Circle CI](https://circleci.com/gh/OregonDigital/oregondigital_2.svg?style=svg)](https://circleci.com/gh/OregonDigital/oregondigital\_2)
[![Coverage Status](https://coveralls.io/repos/osulp/oregondigital_2/badge.svg)](https://coveralls.io/r/osulp/oregondigital\_2)


Local Development Setup
-----

Requirements:

- **Ruby Version: 2.0**
- **IIIF-compatible image server** - see [IIIF setup](IIIFSetup.md)

Configuration and database creation:

**Note:** To prevent errors, you may need to prefix the rake commands with `bundle exec`, which can be required in some systems. 

    git clone git@github.com:OregonDigital/oregondigital_2.git
	cd oregondigital_2
	bundle install
	rake db:migrate
	rake jetty:clean
	rake jetty:config

Start the servers:

    rake jetty:start
	rails server

You can go to your browser and open `http://localhost:3000`, where you can see the Rails app running. When you access `http://localhost:8983` Jetty should list the available contexts (solr and fedora)

Run tests with RSpec:

    rspec spec

Set up a dev admin user:

    rake admin_user

Log in to the app as "admin@example.org" with password "admin123".
