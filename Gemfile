source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.7'
gem 'pg', '~> 0.18'
gem 'puma', '~> 4.3'
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

ruby "2.6.8"
