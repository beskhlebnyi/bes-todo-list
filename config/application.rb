require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module TemplateProject
  class Application < Rails::Application
    config.load_defaults 5.1
    config.active_job.queue_adapter = :sidekiq
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :ru]

    config.generators do |g|
      g.test_framework :rspec,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end
  end
end


