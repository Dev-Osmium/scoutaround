ruby '2.5.1'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'aws-sdk-s3', '~> 1.2'
gem 'bootsnap', require: false
gem 'bootstrap', '~> 4.1.1'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-tagsinput-rails'
gem 'cleavejs-rails'
gem 'cocoon'
gem 'coffee-rails', '~> 4.2'
gem 'combine_pdf'
gem 'config'
gem 'devise'
# gem 'devise_invitable'
gem 'faraday'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-validation-rails'
gem 'jquery-ui-rails'
gem 'mini_magick'
gem 'mixpanel-ruby'
gem 'momentjs-rails'
gem 'local_time'
gem 'pdfjs_viewer-rails'

# web server
gem 'puma', '~> 3.7'

# authorization
gem 'pundit'

# the grand poobah
gem 'rails', '~> 5.2.1'

# markdown rendering
gem 'redcarpet'

# server-side file zipping
gem 'rubyzip'

# SASS preprocessor
gem 'sass-rails', '~> 5.0'

# better seeds
gem 'seedbank'

# autocomplete search functionality
gem 'selectize-rails'

# asynchronous job management
gem 'sidekiq'

# form rendering
gem 'simple_form'

# APM
gem 'skylight'

# HTML preprocessor
gem 'slim'

# CSV import and export
gem 'smarter_csv'

# credit card payments
gem 'stripe'

# rich editor
gem 'trix-rails', git: 'https://github.com/bcoia/trix.git', require: 'trix'

# auto-completion
gem 'twitter-typeahead-rails'
gem 'turbolinks', '~> 5'
gem 'tzinfo' #, git: 'https://github.com/tzinfo/tzinfo'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.7'
  gem 'selenium-webdriver'
  gem 'sqlite3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'guard-rspec', require: false
  gem 'scout_apm'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production, :staging do
  gem 'pg'
  gem 'sentry-raven'
end

group :staging do
  gem 'sanitize_email'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
  gem 'launchy'
end
