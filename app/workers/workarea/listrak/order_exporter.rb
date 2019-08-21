module Workarea
  module Listrak
    class OrderExporter
      include Sidekiq::Worker
      include Sidekiq::CallbacksWorker

      sidekiq_options(
        enqueue_on: {
          Workarea::Order => :place
        }
      )

      def perform(order_id)
        order = Workarea::Order.find order_id

        order_form = Listrak::Models::OrderForm.new order

        Listrak.data.orders.import [order_form]
      end
    end
  end
end
