require 'test_helper'

module Workarea
  module Listrak
    class DataApi::ProductsTest < TestCase
      def test_import
        VCR.use_cassette 'listrak/data_api/products_import-successful' do
          product = create_product

          product_forms = product.skus.map do |sku|
            create_inventory id: sku
            Listrak::Models::ProductForm.new(product, sku)
          end

          data_api.products.import product_forms
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
