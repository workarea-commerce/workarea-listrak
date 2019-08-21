module Workarea
  module Listrak
    # Generate new Message classes for your host app (or plugin).
    class MessageGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def copy_agent
        template(
          "message.rb.erb",
          "app/messages/workarea/#{file_name}_message.rb"
        )
      end
    end
  end
end
