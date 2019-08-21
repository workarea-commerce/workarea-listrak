require 'test_helper'

module Workarea
  module Listrak
    class EmailApi::TransactionalMessagesTest < TestCase
      def test_create
        VCR.use_cassette 'listrak/email_api/transactional_messages_create-successful' do
          transactional_message_form = Listrak::Models::TransactionalMessageForm.new(
            email_address: 'plugins@workarea.com',
            segmentation_field_values: [
              { segmentationFieldId: 2446151, value: 'Ben' },
              { segmentationFieldId: 2446152, value: 'Crouse' },
              { segmentationFieldId: 2446153, value: '22 S. 3rd St.' },
              { segmentationFieldId: 2446154, value: 'Second Floor' },
              { segmentationFieldId: 2446155, value: 'Philadelphia' },
              { segmentationFieldId: 2446156, value: 'PA' },
              { segmentationFieldId: 2446157, value: '19106' },
              { segmentationFieldId: 2446158, value: 'US' },
              { segmentationFieldId: 2446159, value: "" },
              { segmentationFieldId: 2446169, value: "1234" },
              { segmentationFieldId: 2446174, value: "" },
              { segmentationFieldId: 2446175, value: Time.current.to_s },
              { segmentationFieldId: 2446179, value: "10.00" },
              { segmentationFieldId: 2446180, value: "0.00" },
              { segmentationFieldId: 2446181, value: "1.00" },
              { segmentationFieldId: 2446182, value: "0.00" },
              { segmentationFieldId: 2446183, value: "11.00" },
              { segmentationFieldId: 2446184, value: "1" }
            ]
          )

          response = email_api.transactional_messages.create(
            349984,
            11838256,
            transactional_message_form
          )

          assert response.present?
        end
      end

      private

        def email_api
          @email_api ||= Listrak::EmailApi.new client_id: 'doyfni0aw64ogd84ld6t',
            client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5JU'
        end
    end
  end
end
