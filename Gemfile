source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.4'

gem 'bundler', '1.16.1'
gem 'rails', '~> 5.2.2'
gem 'mysql2', '0.4.8'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', '~> 2.7.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_rewinder', '~> 0.8.2'
  gem 'factory_bot_rails', '~> 4.8.0'
  gem 'rspec-json_matcher'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'rspec-request_describer', '~> 0.2.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
