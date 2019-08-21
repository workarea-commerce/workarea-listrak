require 'test_helper'

module Workarea
  module Listrak
    class ProductExporterTest < TestCase
      include Workers

      setup :store_bogus_client_requests
      teardown :reset_bogus_client_requests

      def test_exporting_from_product_save
        Sidekiq::Callbacks.enable(Listrak::ProductExporter) do

          create_product(
            variants: [
              { sku: 'SKU1', regular: 5.00 },
              { sku: 'SKU2', regular: 5.00 },
            ]
          )
          Pricing::Sku.find("SKU2").tap do |sku|
            sku.prices.first.regular = 6.00
            sku.save
          end

          assert_equal 2, BogusDataApi.requests[:products][:import].size
        end
      end

      def test_exporting_from_updating_price
        create_product(
          variants: [
            { sku: 'SKU1', regular: 5.00 }
          ]
        )
        pricing_sku = Pricing::Sku.find('SKU1')
        price = pricing_sku.prices.first

        Sidekiq::Callbacks.enable(Listrak::ProductExporter) do
          price.update_attributes(
            regular: 0.44,
            sale: 0.30,
            min_quantity: 1,
            active: true
          )

          assert_equal 1, BogusDataApi.requests[:products][:import].size
        end
      end

      private

        def store_bogus_client_requests
          Workarea::Listrak::BogusDataApi.store_requests = true
          Workarea::Listrak::BogusDataApi.reset_requests!
        end

        def reset_bogus_client_requests
          Workarea::Listrak::BogusDataApi.store_requests = false
        end
    end
  end
end
