source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails"
gem "rails-i18n"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache and Active Job
gem "solid_cache"
gem "solid_queue"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Tailwindcss for styling
gem "tailwindcss-rails"

# Pghero dashboard for Postgres related information
gem "pghero"

# Strong migrations catches unsafe migrations in development
gem "strong_migrations"

# Prosopite catches n+1 queries
gem "pg_query"
gem "prosopite"

# Framework for creating reusable, testable & encapsulated view components
gem "view_component"

# Rails engine for static pages
gem "high_voltage"

# Devise for authentication
gem "devise"
gem "devise-i18n"

# I prefer Haml for views (easy to read)
gem "haml-rails"
gem "html2haml"

# Lucide icons for Rails [https://lucide.dev/icons/]
gem "lucide-rails"

# Authorization system
gem "pundit"

# Pretty URLs and work with human-friendly strings
gem "babosa"
gem "friendly_id"

# Image processing for ActionText
gem "image_processing", "~> 1.14"

# Simple, efficient background jobs for Ruby.
gem "sidekiq"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Rubocop for static code analysis
  gem "rubocop", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false

  # Annotaterb for annotating models with database information
  gem "annotaterb"

  # Finds missing foreign keys/indexes
  gem "active_record_doctor"

  # Compares DB constraints with model validations
  gem "database_consistency"

  # Patch-level verification for bundler
  gem "bundler-audit"

  # RSpec as testing framework
  gem "rails-controller-testing"
  gem "rspec-rails"

  # Fixtures replacement with a straightforward definition syntax
  gem "factory_bot_rails"

  # Faker for generating fake data
  gem "faker"

  # Byebug for debugging
  gem "byebug"

  # Code coverage analysis tool for Ruby.
  gem "simplecov", require: false

  # Use dotenv for local environment variables
  gem "dotenv-rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Lookbook shows you how your view components look in isolation
  gem "lookbook"
end
