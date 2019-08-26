source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'multi_json'
gem 'uglifier'
gem 'jquery-rails'
gem 'active_model_serializers', '~> 0.10.6'
gem 'omniauth-heroku'
gem 'platform-api'
gem 'tzinfo-data'

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "launchy"
  gem "database_cleaner"
end

ruby "2.6.3"
