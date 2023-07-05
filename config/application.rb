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

    config.before_configuration do
      ENV['PAYPAL_CLIENT_ID'] = 'AaJw_nDWquzT3-RqQp8BIaIYuBoNpZOy7SoXHdkJUStK6oKhyONtvoy-2YIDSt8SRuVgrcvvTUSmo0X2'
      ENV['PAYPAL_SECRET_ID'] = 'EC7nUNUdcrKX_F0B4VreT7vvLq-b9MmmZAhOEJqnUw4k8H94k6Y1VhvSoNrK8zp2RNJlCxtP98l6Y4Ad'
      ENV['PAYPAL_SANDBOX_URL'] = 'https://api-m.sandbox.paypal.com'
    end
  end
end
