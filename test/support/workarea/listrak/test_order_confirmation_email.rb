module Workarea
  module Listrak
    class TestOrderConfirmationEmail
      include Listrak::TransactionalMessage

      attr_reader :order

      message_id 11838256
      message_attributes(
        shipping_first_name: 2446151,
        shipping_last_name: 2446152,
        shipping_street_address1: 2446153,
        shipping_street_address2: 2446154,
        shipping_city: 2446155,
        shipping_state: 2446156,
        shipping_zip: 2446157,
        shipping_country: 2446158,
        shipping_phone: 2446159,
        order_number: 2446169,
        shipping_method: 2446174,
        order_date: 2446175,
        sub_total: 2446179,
        tax: 2446180,
        shipping_cost: 2446181,
        discount: 2446182,
        grand_total: 2446183,
        purchased_item_count: 2446184,
      )

      def initialize(order)
        @order = order
      end

      private

        def email_address
          order.email
        end

        def shipping
          @shipping ||= Shipping.find_by order_id: order.id
        end

        def shipping_first_name
          shipping.address.first_name
        end

        def shipping_last_name
          shipping.address.last_name
        end

        def shipping_street_address1
          shipping.address.street
        end

        def shipping_street_address2
          shipping.address.street_2
        end

        def shipping_city
          shipping.address.city
        end

        def shipping_state
          shipping.address.region
        end

        def shipping_zip
          shipping.address.postal_code
        end

        def shipping_country
          shipping.address.country.alpha2
        end

        def shipping_phone
          shipping.address.phone_number
        end

        def order_number
          order.id
        end

        def shipping_method
        end

        def order_date
          order.placed_at.to_s
        end

        def sub_total
          order.subtotal_price.to_s
        end

        def tax
          order.tax_total.to_s
        end

        def shipping_cost
          order.shipping_total.to_s
        end

        def discount
          0.to_m.to_s
        end

        def grand_total
          order.total_price.to_s
        end

        def purchased_item_count
          order.items.size
        end
    end
  end
end
