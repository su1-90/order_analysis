source "https://rubygems.org"

ruby "3.3.0"
gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis
# gem "kredis"

# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "devise"
gem "dotenv-rails"
gem "ruby-openai"
gem "kaminari"
gem "bootstrap5-kaminari-views"
gem "csb"
gem "sassc-rails"
gem "uglifier", ">= 1.3.0"
gem "webpacker", ">= 5.0"
gem "nokogiri", "~> 1.18.2", platforms: [:ruby]
gem "coffee-rails", "~> 4.2"


gem 'mini_racer', platforms: :ruby