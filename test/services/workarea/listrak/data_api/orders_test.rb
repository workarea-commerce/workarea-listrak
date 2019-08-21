require 'test_helper'

module Workarea
  module Listrak
    class DataApi::OrdersTest < TestCase
      def test_import
        VCR.use_cassette 'listrak/data_api/orders_import-successful' do
          order = create_placed_order

          order_form = Listrak::Models::OrderForm.new(order)

          data_api.orders.import [order_form]
        end
      end

      private

        def data_api
          @data_api ||= Listrak::DataApi.new client_id: 'a',
            client_secret: 'ZMOhwRN2MhkP0xicWzcu1rtEY9sjDUq/reVovZOY41U'
        end
    end
  end
end
