source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'slim', '~> 3.0', '>= 3.0.7'
gem 'devise', '~> 4.2'
gem 'simple_form', '~> 3.4'
gem 'paperclip', '~> 5.1'
gem 'pundit', '~> 1.1'
gem 'virtus', '~> 1.0.5'
gem 'chosen-rails', '~> 1.5', '>= 1.5.2'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.1'
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'validates_timeliness', '~> 4.0'
gem 'groupdate'
gem 'ransack', '~> 1.8', '>= 1.8.2'
gem 'cocoon', '~> 1.2', '>= 1.2.9'
gem 'validate_url', '~> 1.0', '>= 1.0.2'
gem 'chartkick', '~> 3.3'
gem 'roo', '~> 2.7.0'
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'httparty', '~> 0.14.0'
gem 'nokogiri', '~> 1.7', '>= 1.7.1'
gem 'whenever', '~> 0.9.7'
gem 'pdf-reader', '~> 2.0'
gem 'jwt', '~> 1.5.6'
gem 'omniauth'
gem 'rack-cors', :require => 'rack/cors'
gem 'twilio-ruby', '~> 4.11.1'
gem 'kaminari', '~> 1.0.1'
gem 'pdf-inspector'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'rails_12factor'
  gem 'yui-compressor'
  gem 'delayed_job_active_record'
  gem 'daemons'
end