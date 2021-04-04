source 'https://rubygems.org'

ruby '>= 2.6.4', '< 3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'y
gem 'rails', '4.2.11.3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'


# Use Unicorn as the app server
# gem 'unicorn'

gem 'themoviedb'

gem 'geokit', '~> 1.13.1'

# Window support
gem 'tzinfo'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'sqlite3', '1.3.11'

  # Access an IRB console on exception pages or by using <%= console %> in views
  
end

gem 'web-console', '~> 2.0', group: :development

group :production do
  gem 'pg', '~> 0.21' # for Heroku deployment
  gem 'rails_12factor'
end

group :development, :test do
  gem "factory_bot_rails"
  # or
  gem "factory_bot"
end
gem "factory_girl", "~> 4.9"

gem "factory_girl_rails", "~> 4.9"

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
end
gem "database_cleaner", "~> 1.99"

gem "geocoder", "~> 1.6"

gem "aws-sdk-sns", "~> 1.39"
