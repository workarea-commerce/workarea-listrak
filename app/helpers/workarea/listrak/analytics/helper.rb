module Workarea
  module Listrak
    module Analytics
      module Helper
        def order_analytics_data(order)
          super.merge(
            user_id: order.user_id,
            email: order.email,
            subtotal_price: order.subtotal_price.to_f,
            first_name: order_first_name(order),
            last_name: order_last_name(order)
          )
        end

        def cart_view_analytics_data(order)
          event = super
          payload = event[:payload].merge(
            token: order.token
          )
          event.merge(payload: payload)
        end

        def order_item_analytics_data(item)
          super.merge(
            image_url: product_image_url(item.image, :large_thumb),
            slug: item.product.to_param
          )
        end

        private

          def order_first_name(order)
            order.shipping_address.try(:first_name) ||
              order.try(:user).try(:first_name)
          end

          def order_last_name(order)
            order.shipping_address.try(:last_name) ||
              order.try(:user).try(:last_name)
          end
      end
    end
  end
end
