module Workarea
  module Listrak
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::Listrak

      config.to_prepare do
        Storefront::ApplicationController.helper Listrak::Analytics::Helper
      end
    end
  end
end
