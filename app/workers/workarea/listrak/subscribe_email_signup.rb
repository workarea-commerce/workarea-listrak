module Workarea
  module Listrak
    class SubscribeEmailSignup
      include Sidekiq::Worker
      include Sidekiq::CallbacksWorker

      sidekiq_options(
        enqueue_on: {
          Email::Signup => :create
        },
        queue: "low",
        retry: true
      )

      def perform(id)
        signup = Email::Signup.find id
        list_id = Listrak.configuration.default_list_id
        event_ids = Array.wrap(Listrak.configuration.external_event_ids).to_csv(row_sep: nil).presence

        contact = Listrak::Models::ContactForm.new(
          email: signup.email,
          subscription_state: 'Subscribed'
        )

        options = {
          overrideUnsubscribe: true,
          eventIds: event_ids
        }.compact

        Listrak.email.contacts.upsert list_id, contact, options
      end
    end
  end
end
