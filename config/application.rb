require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require 'neo4j/railtie'
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IFTF
  TOP_TAG_NUM = 3;
  class Application < Rails::Application
    
    config.generators do |g|
      g.orm             :neo4j
    end

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.neo4j.session_type = :server_db
    config.neo4j.session_path = 'http://23.92.30.186:7474'
    config.neo4j._active_record_destroyed_behavior = true
    config.neo4j.session_option = {basic_auth: { username: 'neo4j', password:'cynebr9zqleby0'}}

    config.to_prepare do
        DeviseController.respond_to :html, :js, :json
    end
    # Configure where the embedded neo4j database should exist
    # Notice embedded db is only available for JRuby
    # config.neo4j.session_type = :embedded_db  # default #server_db
    # config.neo4j.session_path = File.expand_path('neo4j-db', Rails.root)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
