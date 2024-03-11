source 'https://rubygems.org'

ruby '3.1.4'

gem 'rails', '~> 7.1.3'

gem 'dotenv-rails'
gem 'importmap-rails'
gem 'jbuilder'
gem 'puma', '>= 5.0'
gem 'sidekiq', '~> 7.2', '>= 7.2.2'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'stimulus-rails'
gem 'themoviedb-api'
gem 'turbo-rails'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.1.0'
end

group :development do
  gem 'error_highlight', '>= 0.6.0', platforms: [:ruby]
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 6.0'
  gem 'vcr'
  gem 'webmock'
end
