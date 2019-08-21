require 'test_helper'

module Workarea
  module Listrak
    class DataApi::CustomersTest < TestCase
      def test_import
        VCR.use_cassette 'listrak/data_api/customers_import-successful' do
          user = create_user(addresses: [
            {
              first_name: 'Ben',
              last_name: 'Crouse',
              street: '22 S. 3rd St.',
              street_2: 'Second Floor',
              city: 'Philadelphia',
              region: 'PA',
              postal_code: '19106',
              country: 'US'
            }
          ])

          customer_form = Listrak::Models::CustomerForm.new(user)

          data_api.customers.import [customer_form]
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
