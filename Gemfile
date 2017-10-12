source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rake', '~> 12.1.0'
gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Authentication
gem 'devise'
gem 'simple_form'

# Image managing
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
gem 'gravtastic'

# Simple library for validating addresses
gem 'bitcoin-ruby'

# Faciliate spanish lang implementation
gem 'rails-i18n'
gem 'devise-i18n'

gem 'will_paginate', '~> 3.1.0'
gem 'premailer-rails'
gem 'figaro'
gem 'whenever', :require => false
gem 'mail_form', '~> 1.6'
gem "recaptcha", require: "recaptcha/rails"
gem 'newrelic_rpm'

group :development do
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-rails', '~> 1.2', '>= 1.2.3'
  gem 'capistrano-rbenv', '~> 2.1'
end

group :development do
  gem 'irbtools', require: 'irbtools/binding'
  gem 'awesome_print'
end

gem 'delayed_job_active_record'
