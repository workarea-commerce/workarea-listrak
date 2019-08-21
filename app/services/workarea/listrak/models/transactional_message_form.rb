module Workarea
  module Listrak
    module Models
      class TransactionalMessageForm
        attr_reader :email_address, :segmentation_field_values

        def initialize(email_address:, segmentation_field_values: [])
          @email_address = email_address
          @segmentation_field_values = segmentation_field_values
        end

        def to_json
          {
            emailAddress: email_address,
            segmentationFieldValues: segmentation_field_values
          }.compact.to_json
        end
      end
    end
  end
end
