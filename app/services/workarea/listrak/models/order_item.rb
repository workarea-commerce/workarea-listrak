module Workarea
  module Listrak
    module Models
      class OrderItem

        attr_reader :order, :order_item

        def initialize(order, order_item)
          @order = order
          @order_item = order_item
        end

        def as_json
          {
            discountDescription: discount_description,
            discountType: discount_type,
            discountedPrice: discount_price,
            itemTotal: item_total,
            itemDiscountTotal: item_discount_total,
            meta1: meta1,
            meta2: meta2,
            meta3: meta3,
            meta4: meta4,
            meta5: meta5,
            orderNumber: order_number,
            price: price,
            quantity: quantity,
            shipDate: ship_date,
            shippingMethod: shipping_method,
            sku: sku,
            status: status,
            trackingNumber: tracking_number
          }
        end

        # Description of the discount for the line item
        #
        # @return [String]
        #
        def discount_description
        end

        # Type of discount for the line item
        #
        # "NotSet" "PriceOverride" "PriceRule" "Promotion" "SeniorCitizen" "Markdown" "Coupon" "QuantityDiscount" "Rebate" "CashDiscount" "TradeDiscount" "TradeInKind" "PromptPaymentDiscount" "GeneralDiscount" "GiftVoucher" "FlexibleDiscount" "RewardProgram" "ManufacturerReward" "CreditCardReward"
        #
        # @return [String]
        #
        def discount_type
        end

        # Total discounted cost of product
        #
        # @return [Float]
        #
        def discount_price
          order_item.price_adjustments
            .select { |pa| pa.data['discount_value'].present? && pa.price == 'item' }
            .sum { |d| d.data['discount_value'] }
            .abs
        end

        # Total line item cost (quantity times price)
        #
        # @return [Float]
        #
        def item_total
          order_item.total_value.to_f
        end

        # Total amount of the discount for the line item
        #
        # @return [Float]
        #
        def item_discount_total
          order_item.price_adjustments
            .select { |pa| pa.data['discount_value'].present? && pa.price == 'item' }
            .sum { |d| d.data['discount_value'] }
            .abs
        end

        # Additional Optional Information
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def meta1
        end

        # Additional Optional Information
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def meta2
        end

        # Additional Optional Information
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def meta3
        end

        # Additional Optional Information
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def meta4
        end

        # Additional Optional Information
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def meta5
        end

        # Order number
        #
        # limited to 50 characters
        #
        # @return [String]
        #
        def order_number
          order.id.to_s
        end

        # Price of one unit purchased
        #
        # @return [Float]
        #
        def price
          order_item.original_unit_price.to_f
        end

        # Total number of units purchased
        #
        # return [Integer]
        #
        def quantity
          order_item.quantity
        end

        # Timestamp when item shipped (ET)
        #
        # @return [String] DateTime in %FT%TZ
        #
        def ship_date
        end

        # Shipping method (e.g. UPS Ground)
        #
        # limited to 32 characters
        #
        # @return [String]
        #
        def shipping_method
        end

        # Unique stock number of product
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def sku
          order_item.sku
        end

        # Status indicator
        #
        # "NotSet" "Misc" "PreOrder" "BackOrder" "Pending" "Hold" "Processing" "Shipped" "Completed" "Returned" "Canceled" "Unknown" "Closed"
        #
        # @return [String]
        #
        def status
        end

        # Shipment tracking number
        #
        # limited to 32 characters
        #
        def tracking_number
        end
      end
    end
  end
end
