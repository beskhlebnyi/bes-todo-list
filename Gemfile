source 'https://rubygems.org'

ruby '2.5.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.2'
gem 'pg'
gem 'puma', '~> 3.7'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'slim-rails'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jquery-ui-rails'
gem 'devise', '~> 4.2'
gem 'bootstrap'
gem 'font-awesome-rails'
gem 'sidekiq'
gem 'letter_opener'
gem 'sidekiq-scheduler'
gem 'geocoder'
gem 'timezone'
gem 'figaro'

source 'https://rails-assets.org' do
  gem 'rails-assets-datetimepicker'
end

group :development, :test do  
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]  
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'chromedriver-helper'
  gem 'capybara-screenshot'
  gem "webdrivers"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
