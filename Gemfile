source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 7.0.3.1'
gem 'sprockets-rails'

gem 'pg', '~> 1.4.1'
gem 'puma', '~> 5.6.7'
gem 'multi_json'
gem 'uglifier'
gem 'jquery-rails', '>= 4.3.5'
gem 'active_model_serializers', '~> 0.10.10'
gem 'omniauth-heroku'
gem 'omniauth-rails_csrf_protection'
gem 'platform-api'
gem 'tzinfo-data'

group :development, :test do
  gem 'dotenv-rails', '>= 2.7.5'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", ">= 3.9.1"
  gem "rspec_junit_formatter"
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "launchy"
  gem "database_cleaner"
end

ruby "3.1.2"
