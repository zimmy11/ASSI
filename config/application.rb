require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EventMaster
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    Rails.application.config.hosts << "www.sandbox.paypal.com"
    Rails.application.config.hosts << "rude-bushes-add.loca.lt"
    Rails.application.config.hosts << "example.com"
  
    config.before_configuration do
      ENV['PAYPAL_CLIENT_ID'] = 'AWOXkW5IPxQan15qlqldxe7GnB22UlQugme-zGg0BlBroLYKLyZtmR5-jF-UptGAxc0DkUlfc3LKJTnb'
      ENV['PAYPAL_SECRET_ID'] = 'EGKwmR1gZWWMHWhfHPE8ttpjxH61CY6DQiUrYwlG41VJYWI_X2nA6fYXpfzXa9gxqyFyadNm11XItjPZ'
      ENV['PAYPAL_SANDBOX_URL'] = 'https://api-m.sandbox.paypal.com'
    end
  end
end
