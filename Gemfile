source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Webpacker React
gem 'webpacker-react', "~> 0.2.0"

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
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

# Devise para autenticacion de usuarios
gem "devise", git: 'https://github.com/plataformatec/devise.git'
# Haml para las vistas
gem 'haml-rails'
# Anotaciones de los modelos
gem 'annotate'
# Best in place
gem 'best_in_place', '~> 3.1'
# Jquery
gem 'jquery-rails', '~> 4.1', '>= 4.1.1'
# Postgres temp
gem 'pg'
# Para los filtrados en los reportes
gem 'filterrific'
# Graficas
gem "chartkick"
# Para busquedas en los modelos
gem 'searchkick'
# Rails admin
gem 'rails_admin', '~> 1.3'
# Oracle DBC
gem 'activerecord-oracle_enhanced-adapter', '~> 1.8.1'
# gem 'therubyracer', platforms: :ruby
gem 'ruby-oci8' # only for CRuby users
# gem 'ruby-plsql', '~> 0.6.0'
# Trabajos en segundo plano
gem 'whenever', :require => false
# Javascript runtime
gem 'therubyracer'
gem 'execjs'

# Deployment
gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-lets-encrypt'

# Add this if you're using rbenv
gem 'capistrano-rbenv', '~> 2.1'

# Consola remota
gem 'capistrano-rails-console', require: false

# Utilidades
gem 'react-rails'

#Prevencion de ataques
gem 'rack-attack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
end



group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
