require 'test_helper'

module Workarea
  module Listrak
    class OrderExporterTest < TestCase
      include Workers

      setup :store_bogus_client_requests
      teardown :reset_bogus_client_requests

      def test_exporting_an_order
        Sidekiq::Callbacks.enable(Listrak::OrderExporter) do
          create_placed_order

          assert_equal 1, BogusDataApi.requests[:orders][:import].size
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
