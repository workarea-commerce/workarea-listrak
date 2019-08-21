module Workarea
  module Listrak
    module Models
      class ProductForm
        include ActionView::Helpers::AssetUrlHelper
        include Workarea::I18n::DefaultUrlOptions
        include Workarea::ApplicationHelper
        include Storefront::Engine.routes.url_helpers


        # @param [Workarea::Catalog::Product] product
        # @param [String] sku
        def initialize(product, sku, pricing_sku: nil, inventory_sku: nil)
          @product = product
          @sku = sku
          @pricing_sku = pricing_sku
          @inventory_sku = inventory_sku
        end

        def as_json(_options)
          {
            brand: brand,
            category: category,
            color: color,
            description: description,
            discontinued: discontinued,
            gender: gender,
            imageUrl: image_url,
            inStock: in_stock,
            isClearance: is_clearence,
            isOutlet: is_outlet,
            isPurchasable: is_purchasable,
            isViewable: is_viewable,
            linkUrl: link_url,
            masterSku: master_sku,
            meta1: meta1,
            meta2: meta2,
            meta3: meta3,
            meta4: meta4,
            meta5: meta5,
            msrp: msrp,
            onSale: on_sale,
            price: price,
            qoh: quantity_on_hand,
            saleEndDate: sale_end_date,
            salePrice: sale_price,
            saleStartDate: sale_start_date,
            size: size,
            sku: sku,
            style: style,
            subCategory: sub_category,
            title: title,
            unitCost: unit_cost
          }.compact
        end

        # Brand name of product
        #
        # limited to 50 characters
        #
        # @return [String]
        #
        def brand
          product.try(:brand)
        end

        # Category or department
        #
        # limited to 50 characters
        #
        # @return [String]
        #
        def category
          categorization.default_model.try(:name)
        end

        # Color of product (e.g. green, paisley, etc.)
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def color
          variant.fetch_detail('color')
        end

        # Description of product
        #
        # limited to 4000 characters
        #
        # @return [String]
        #
        def description
          product.description
        end

        # Explicit indicator that the item has been discontinued
        #
        # @return [Boolean]
        #
        def discontinued
        end

        # Gender of product (if applicable)
        #
        # limited to 50 characters
        #
        # @return [String]
        #
        def gender
        end

        # URL for product image
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def image_url
          return unless image = variant_image || product.images.first
          @image_url ||= product_image_url(image, :detail)
        end

        # Explicit indicator that the item is in stock
        #
        # @return [Boolean]
        #
        def in_stock
          quantity_on_hand > 0
        end

        # Explicit indicator that the item is a clearance item
        #
        # @return [Boolean]
        #
        def is_clearence
        end

        # Explicit indicator that the item is an outlet item
        #
        # @return [Boolean]
        #
        def is_outlet
        end

        # Explicit indicator that the item can be included in recommendations
        #
        # @return [Boolean]
        #
        def is_purchasable
          product.purchasable? && inventory_sku.purchasable?
        end

        # Flag used in some systems to determine if the item should be included in recommendations
        #
        # @return [Boolean]
        #
        def is_viewable
          product.purchasable? && inventory_sku.purchasable?
        end

        # URL for product webpage
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def link_url
          product_url(product, host: Workarea.config.host)
        end

        # Unique stock number of the master product
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def master_sku
          product.id.to_s
        end

        # Additional meta imformation
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta1
        end

        # Additional meta imformation
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta2
        end

        # Additional meta imformation
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta3
        end

        # Additional meta imformation
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta4
        end

        # Additional meta imformation
        #
        # limted to 500 characters
        #
        # @return [String]
        #
        def meta5
        end

        # Retail price of the product
        #
        # @return [Float]
        #
        def msrp
        end

        # Explicit indicator that the item is on sale
        #
        # @return [Boolean
        #
        def on_sale
          pricing_sku.on_sale?
        end

        # List price of product
        #
        # @return [Float]
        #
        def price
          pricing_sku.find_price.sell.to_f
        end

        # Quantity on hand
        #
        # return [Integer]
        #
        def quantity_on_hand
          inventory_sku.available
        end

        # End date time of sale
        #
        # @return [String] sale_end_date DateTime in %FT%TZ
        #
        def sale_end_date
        end

        # Sale price of product
        #
        # @return [Float
        #
        def sale_price
          pricing_sku.find_price.sale.to_f
        end

        # Start date time of sale
        #
        # @return [String] sale_start_date DateTime in %FT%TZ
        #
        def sale_start_date
        end

        # Size of product (e.g. small, M, 6 7/8”)
        #
        # limited to 50 characters
        #
        # @return [String]
        #
        def size
          variant.fetch_detail('size')
        end

        # Unique stock number of product
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def sku
          @sku
        end

        # Style of product
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def style
        end

        # Sub-category or sub-department
        #
        # limited to 50 characters
        #
        # @return [String]
        #
        def sub_category
          categorization.secondary_model.try(:name)
        end

        # Product name
        #
        # limited to 500 characters
        #
        # @return [String]
        #
        def title
          product.name
        end

        # Price per individual item
        #
        # @return [Float]
        #
        def unit_cost
        end

        private

          attr_reader :product

          def categorization
            @categorization ||= Categorization.new(product)
          end

          def variant
            @variant ||= product.variants.find_by(sku: sku)
          end

          def pricing_sku
            @pricing_sku ||= Pricing::Sku.find sku
          end

          def inventory_sku
            @inventory_sku ||= Inventory::Sku.find sku
          end

          def variant_image
            @variant_image ||=
              begin
                sku_options = variant.details.values.flat_map { |options| options.map(&:optionize) }

                product.images.detect do |image|
                  sku_options.include?(image.option.optionize)
                end
              end
          end
      end
    end
  end
end
