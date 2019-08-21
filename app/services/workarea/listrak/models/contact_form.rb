module Workarea
  module Listrak
    module Models
      class ContactForm
        SUBSCRIBED_STATES = ['Subscribed', 'Unsubscribed']
        attr_reader :email, :subscription_state, :options

        def initialize(email:, subscription_state: nil, **options)
          @email = email
          @subscription_state = subscription_state.presence_in SUBSCRIBED_STATES
          @options = options
        end

        def to_json
          {
            emailAddress: email,
            subscriptionState: subscription_state,
            segmentationFieldValues: nil
          }.to_json
        end
      end
    end
  end
end
