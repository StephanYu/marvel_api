source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'rack-cors'
gem 'figaro'
gem 'httparty'
gem 'sidekiq'
gem 'whenever', :require => false
# gem 'redis', '~> 3.0'

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails', '3.1.0'
  gem 'factory_girl_rails'
  gem 'vcr', '3.0.3'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do 
  gem 'shoulda-matchers', '~> 3.1'
end 

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
