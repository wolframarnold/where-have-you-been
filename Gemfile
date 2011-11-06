source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '~> 1.3.4'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'bourbon', '~> 1.0.4'
gem 'flutie', '~> 1.3.3'
gem 'jquery-rails', '~> 1.0.16'
gem 'haml', '~> 3.1.3'
gem 'haml-rails', '~> 0.3.4'
gem 'devise', '~> 1.4.8'
gem 'simple_form', '~> 1.5.2'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'rspec-rails', '~> 2.6.1'
  gem 'thin'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec2-rails-views-matchers', '~> 0.2.0'
  gem 'webrat', '~> 0.7.3'
  gem 'factory_girl_rails', '~> 1.3.0', :require => false # require false for Spork, see: # see: https://github.com/timcharper/spork/wiki/Troubleshooting
  gem 'spork', '~> 0.9.0rc'
end
