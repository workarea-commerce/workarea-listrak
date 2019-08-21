module Workarea
  module Listrak
    # Base functionality for Listrak message sender classes.
    # +Listrak::TransactionalMessage+ objects wrap a call to the
    # Listrak REST API and allow the user to cleanly define
    # attribute ID / value pairs and "name" them by defining
    # attribute values as method calls.
    #
    # @example
    #   module Workarea
    #     class OrderConfirmationMessage
    #       include Listrak::TransactionalMessage
    #
    #       message_id 12345
    #       message_attributes name: 67890
    #
    #       def initialize(model)
    #         @model = model
    #       end
    #
    #       def name
    #         @model.class.name
    #       end
    #
    #       private
    #
    #         def email_address
    #           model.email_address
    #         end
    #     end
    #   end
    module TransactionalMessage
      extend ActiveSupport::Concern

      included do
        class_attribute :listrak_message_id
        class_attribute :transactional_attributes
      end

      class_methods do
        def message_id(id)
          self.listrak_message_id = id
        end

        def message_attributes(attributes)
          self.transactional_attributes = attributes.symbolize_keys
        end
      end

      # @abstract Subclass is expected to implement #email_address
      # @!method email_address
      #    Email address to deliver this message to

      # Sends the transactional mesasge
      #
      # @return [nil]
      #
      def deliver
        transactional_message_form = Listrak::Models::TransactionalMessageForm.new(
          email_address: email_address,
          segmentation_field_values: segmentation_field_values
        )

        Listrak.email.transactional_messages.create(
          Listrak.configuration.default_list_id,
          listrak_message_id,
          transactional_message_form
        )
        nil
      end

      private

        # @return [Array<Hash>]
        #
        def segmentation_field_values
          transactional_attributes.map do |name, id|
            { segmentationFieldId: id, value: send(name).to_s }
          end
        end
    end
  end
end
