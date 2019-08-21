require "test_helper"

module Workarea
  module Listrak
    module Analytics
      class HelperTest < Workarea::ViewTest
        include Workarea::ApplicationHelper
        include Workarea::Storefront::AnalyticsHelper
        include TestCase::SearchIndexing

        setup do
          @order = Storefront::OrderViewModel.wrap create_placed_order
          @item = @order.items.first
          @product = Catalog::Product.find @item.product_id
        end

        def test_order_analytics_data_extensions
          unless @order.user_id.nil?
            assert_equal @order.user_id, order_analytics_data(@order)[:user_id]
          end
          assert_equal @order.email, order_analytics_data(@order)[:email]
          assert_equal @order.subtotal_price.to_f, order_analytics_data(@order)[:subtotal_price]
          assert_equal @order.shipping_address.first_name, order_analytics_data(@order)[:first_name]
          assert_equal @order.shipping_address.last_name, order_analytics_data(@order)[:last_name]
        end

        def test_cart_view_analytics_data_extensions
          assert_equal @order.token, cart_view_analytics_data(@order)[:payload][:token]
        end

        def test_order_item_analytics_data_extensions
          assert_match %r{/product_images/placeholder}, order_item_analytics_data(@item)[:image_url]
          assert_equal @item.product.to_param, order_item_analytics_data(@item)[:slug]
        end
      end
    end
  end
end
