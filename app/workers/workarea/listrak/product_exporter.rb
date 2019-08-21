module Workarea
  module Listrak
    class ProductExporter
      include Sidekiq::Worker
      include Sidekiq::CallbacksWorker

      sidekiq_options(
        enqueue_on: {
          Catalog::Product => :save,
          Shipping::Sku => :save,
          Pricing::Sku => :save,
          Pricing::Price => :save,
          with: -> { ProductExporter.perform_with(self) }
        }
      )

      def self.perform_with(model)
        case model.class.name
        when "Workarea::Pricing::Price"
          [model.sku.class.name, model.sku.id]
        else
          [model.class.name, model.id]
        end
      end

      def perform(class_name, id)
        product, skus =
          if class_name == "Workarea::Catalog::Product"
            prod = Catalog::Product.find(id)
            [prod, prod.skus]
          else
            [Catalog::Product.find_by_sku(id), [id]]
          end

        return unless product.present?

        inventory = Inventory::Collection.new product.skus
        pricing = Inventory::Collection.new product.skus

        listrak_products = skus.map do |sku|
          Listrak::Models::ProductForm.new product,
            pricing_sku: pricing.for_sku(sku),
            inventory_sku: inventory.for_sku(sku)
        end

        Workarea::Listrak.data.products.import(listrak_products)
      end
    end
  end
end
