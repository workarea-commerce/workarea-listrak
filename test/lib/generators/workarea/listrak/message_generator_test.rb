require "test_helper"
require "generators/workarea/listrak/message/message_generator"

module Workarea
  module Listrak
    class MessageGeneratorTest < Rails::Generators::TestCase
      tests MessageGenerator
      destination Dir.mktmpdir

      MESSAGE_NAME = "OrderConfirmation".freeze
      MESSAGE_PATH = "app/messages/workarea/order_confirmation_message.rb".freeze

      setup do
        prepare_destination
        run_generator [MESSAGE_NAME]
      end

      def test_generates_message_type_class
        assert_file MESSAGE_PATH do |message|
          assert_match "class OrderConfirmationMessage", message
          assert_match "include Listrak::TransactionalMessage", message
        end
      end
    end
  end
end
