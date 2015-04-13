source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Unicorn as the app server
 gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Hydra
gem 'hydra-head', :github => "projecthydra/hydra-head"
gem 'active-fedora', :github => "projecthydra/active_fedora"

# Blacklight
gem 'blacklight'
gem 'rsolr'

# NOID for IDs
gem 'noid'
gem 'active_fedora-noid'

# Constantinople for config values
gem 'constantinople'

# Blacklight Advanced
gem 'blacklight_advanced_search'

gem 'mini_magick'
# Recursive open-struct for YAML Datastream
gem 'recursive-open-struct'

#Vips for pyramidal processing.
gem 'ruby-vips'

gem 'hydra-editor'

gem 'docsplit'

gem 'attr_extras'


group :development, :test do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  gem 'jazz_hands', :github => "terrellt/jazz_hands"
  gem 'capybara'
  gem 'simplecov'
end

group :test do
  gem 'webmock'
  gem 'timecop'
  gem 'database_cleaner'
  gem 'rspec_junit_formatter', :git => 'git@github.com:circleci/rspec_junit_formatter.git'
end

gem 'devise'
gem 'devise-guests', '~> 0.3'
group :development, :test do
  # jettywrapper
  gem 'jettywrapper', :github => "projecthydra/jettywrapper"
end
