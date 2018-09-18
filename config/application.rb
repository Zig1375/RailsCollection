require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}

module Labels
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.generators.javascript_engine = :js


    config.action_mailer.delivery_method = :smtp
    # SMTP settings for gmail
    config.action_mailer.smtp_settings = {
        :address              => "smtp.gmail.com",
        :port                 => 587,
        :user_name            => ENV['gmail_username'],
        :password             => ENV['gmail_password'],
        :authentication       => "plain",
        :enable_starttls_auto => true
    }


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
