module Workarea
  module Listrak
    class UnsubscribeEmailSignup
      include Sidekiq::Worker
      include Sidekiq::CallbacksWorker

      sidekiq_options(
        enqueue_on: {
          Email::Signup => :destroy,
          with: -> { [email] }
        },
        queue: "low",
        retry: true
      )

      def perform(email)
        contact = Listrak::Models::ContactForm.new(
          email: email,
          subscription_state: 'Unsubscribed'
        )

        list_id = Listrak.configuration.default_list_id
        Listrak.email.contacts.upsert list_id, contact, overrideUnsubscribe: true
      end
    end
  end
end
