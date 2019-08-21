module Workarea
  module Listrak
    class CustomerExporter
      include Sidekiq::Worker
      include Sidekiq::CallbacksWorker

      sidekiq_options(
        enqueue_on: {
          Workarea::User => :save
        }
      )

      def perform(user_id)
        user = Workarea::User.find user_id

        customer_form = Listrak::Models::CustomerForm.new user

        Listrak.data.customers.import [customer_form]
      end
    end
  end
end
