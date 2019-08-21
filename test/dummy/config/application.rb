require_relative "boot"

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

require "workarea/core"
require "workarea/admin"
require "workarea/storefront"

Bundler.require(*Rails.groups)

require "workarea/listrak"

module Dummy
  class Application < Rails::Application
  end
end
