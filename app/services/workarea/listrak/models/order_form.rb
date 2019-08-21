module Workarea
  module Listrak
    module Models
      class OrderForm
        attr_reader :order

        def initialize(order)
          @order = order
        end

        def as_json(_options)
          {
            associateID: associate_id,
            billingAddress: billing_address,
            couponCode: coupon_code,
            customerNumber: customer_number,
            dateEntered: date_entered,
            discountTotal: discount_total,
            email: email,
            handlingTotal: handling_total,
            items: items,
            itemTotal: item_total,
            merchandiseDiscount: merchandise_discount,
            merchandiseDiscountDescription: merchandise_discount_description,
            merchandiseDiscountType: merchandise_discount_type,
            meta1: meta1,
            meta2: meta2,
            meta3: meta3,
            meta4: meta4,
            meta5: meta5,
            nonMerchandiseDiscount: non_merchandise_discount,
            nonMerchandiseDiscountDescription: non_merchandise_discount_description,
            nonMerchandiseDiscountType: non_merchandise_discount_type,
            orderNumber: order_number,
            orderTotal: order_total,
            shipDate: ship_date,
            shippingAddress: shipping_address,
            shippingMethod: shipping_method,
            shippingTotal: shipping_total,
            source: source,
            status: status,
            storeNumber: store_number,
            taxTotal: tax_total,
            trackingNumber: tracking_number
          }
        end

        # Associate ID of order
        #
        # @return [String]
        def associate_id
        end

        # Billing address of order
        #
        # @return [Workarea::Listrak::Models::Address]
        #
        def billing_address
          Workarea::Listrak::Models::Address.new payment.address
        end

        # Coupon code used with order
        #
        # limited to 32 characters
        #
        # @return [String]
        #
        def coupon_code
          order.promo_codes.first
        end

        # Internal customer number
        #
        # limited to 20 characters
        #
        # @return [String]
        #
        def customer_number
          order.user_id.to_s
        end

        # Timestamp of order date (ET)
        #
        # @return [String] DateTime in %FT%TZ
        #
        def date_entered
          order.placed_at.strftime '%FT%TZ'
        end

        # Total value of order discount
        #
        # @return [Float]
        #
        def discount_total
          order.price_adjustments
            .select { |pa| pa.data['discount_value'].present? && pa.price != 'item' }
            .sum { |d| d.data['discount_value'] }
            .abs
            .try(:to_f)
        end

        # Email address of customer. This property is required for
        # accounts that are not CRM enabled.
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def email
          order.email
        end

        # Total handling costs
        #
        # @return [Float]
        #
        def handling_total
          shipping.shipping_total.to_f
        end

        # Order items
        #
        # @return [Array<Workarea::Listrak::Models::OrderItem>]
        #
        def items
          @order_items ||= order.items.map do |order_item|
            Workarea::Listrak::Models::OrderItem.new order, order_item
          end
        end

        # Total cost of items ordered (subtotal)
        #
        # @return [Float]
        #
        def item_total
          order.subtotal_price.to_f
        end

        # Discount applied to the merchandise of the order
        #
        # @return [Float]
        #
        def merchandise_discount
          order.price_adjustments
            .select { |pa| pa.data['discount_value'].present? && pa.price == 'item' }
            .sum { |d| d.data['discount_value'] }
            .abs
            .try(:to_f)
        end

        # Description of the discount applied to the merchandise of the order
        #
        # @return [String]
        #
        def merchandise_discount_description
        end

        # Type of discount applied to the merchandise of the order
        #
        # "NotSet" "PriceOverride" "PriceRule" "Promotion" "SeniorCitizen" "Markdown" "Coupon" "QuantityDiscount" "Rebate" "CashDiscount" "TradeDiscount" "TradeInKind" "PromptPaymentDiscount" "GeneralDiscount" "GiftVoucher" "FlexibleDiscount" "RewardProgram" "ManufacturerReward" "CreditCardReward"
        #
        # @return [String]
        #
        def merchandise_discount_type
        end

        # Additional meta information
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def meta1
        end

        # Additional meta information
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta2
        end

        # Additional meta information
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta3
        end

        # Additional meta information
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta4
        end

        # Additional meta information
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta5
        end

        # Discounts applied to the order that is not related to the merchandise
        #
        # @return [Float]
        #
        def non_merchandise_discount
        end

        # Description of the discount applied to the order not related to the merchandise
        #
        # @return [String]
        #
        def non_merchandise_discount_description
        end

        # Type of discount applied to the order not related to the merchandise
        #
        # "NotSet" "PriceOverride" "PriceRule" "Promotion" "SeniorCitizen" "Markdown" "Coupon" "QuantityDiscount" "Rebate" "CashDiscount" "TradeDiscount" "TradeInKind" "PromptPaymentDiscount" "GeneralDiscount" "GiftVoucher" "FlexibleDiscount" "RewardProgram" "ManufacturerReward" "CreditCardReward"
        #
        # @return [String]
        #
        def non_merchandise_discount_type
        end

        # Unique order number
        #
        # limited to 50 characters
        #
        # @return [String]
        #
        def order_number
          order.id.to_s
        end

        # Total value of order
        #
        # return [Float]
        #
        def order_total
          order.total_value.to_f
        end

        # Timestamp when entire order shipped (ET)
        #
        # @return [String]
        #
        def ship_date
        end

        # Shipping address of order
        #
        # @return [Workarea::Listrak::Models::Address]
        #
        def shipping_address
          Workarea::Listrak::Models::Address.new shipping.address
        end

        # Shipping method (e.g. UPS Ground)
        #
        # limted to 32 characters
        #
        # @return [String]
        #
        def shipping_method
          shipping.shipping_service&.name
        end

        # Total shipping costs
        #
        # @return [Float]
        #
        def shipping_total
          order.shipping_total.to_f
        end

        # Describes the source at which the order was placed (online, POS, etc.)
        #
        # limted to 25 characters
        #
        # @return [String]
        #
        def source
          'web'
        end

        # Status indicator
        #
        # "NotSet" "Misc" "PreOrder" "BackOrder" "Pending" "Hold" "Processing" "Shipped" "Completed" "Returned" "Canceled" "Unknown" "Closed"
        #
        # @return [String]
        #
        def status
          order.status
        end

        # Brick and mortar store location
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def store_number
        end

        # Total sales tax charged
        #
        # @return [Float]
        #
        def tax_total
          order.tax_total.to_f
        end

        # Shipment tracking number
        #
        # limited to 32 characters
        #
        # @return [String]
        #
        def tracking_number
        end

        private

          def payment
            @payment ||= Workarea::Payment.find order.id
          end

          def fulfillment
            @fulfillment ||= Workarea::Fulfillment.find order.id
          end

          def shippings
            @shippings ||= Workarea::Shipping.by_order(order.id).to_a
          end

          def shipping
            shippings.first
          end
      end
    end
  end
end
