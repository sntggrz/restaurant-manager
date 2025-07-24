require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp2
  class Application < Rails::Application
    config.load_defaults 8.0

    # >>> Your timezone config
    config.time_zone = "America/Mexico_City"          # how Rails displays/builds times
    config.active_record.default_timezone = :utc      # keep DB in UTC (recommended)
    # <<<

    config.autoload_lib(ignore: %w[assets tasks])
  end
end
