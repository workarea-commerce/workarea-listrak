require 'test_helper'

module Workarea
  module Listrak
    class TransactionalMessageTest < TestCase
      def test_deliver
        Listrak::BogusEmailApi.reset_requests!
        Listrak::BogusEmailApi.store_requests = true
        order = create_placed_order
        create_listrak_configuration(default_list_id: '349984')

        message = TestOrderConfirmationEmail.new order

        message.deliver

        messages = Listrak::BogusEmailApi.requests.dig :transactional_messages, :create
        list_id, message_id, message_form = messages.first

        assert_equal('349984', list_id)
        assert_equal(11838256, message_id)
        expected_form_json = {
          emailAddress: "bcrouse-new@workarea.com",
          segmentationFieldValues: [
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
            { segmentationFieldId: 2446175, value: order.placed_at.to_s },
            { segmentationFieldId: 2446179, value: "10.00" },
            { segmentationFieldId: 2446180, value: "0.00" },
            { segmentationFieldId: 2446181, value: "1.00" },
            { segmentationFieldId: 2446182, value: "0.00" },
            { segmentationFieldId: 2446183, value: "11.00" },
            { segmentationFieldId: 2446184, value: "1" }
          ]
        }.to_json
        assert_equal(expected_form_json, message_form.to_json)
      end
    end
  end
end
