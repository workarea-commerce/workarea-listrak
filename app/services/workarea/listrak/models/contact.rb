module Workarea
  module Listrak
    class Models::Contact
      attr_reader :hash

      def initialize(hash)
        @hash = hash
      end

      # Email address of the contact.
      #
      # @return [String]
      #
      def email_address
        hash['emailAddress']
      end

      # Listrak email key of the contact.
      #
      # @return [String]
      #
      def email_key
        hash['emailKey']
      end

      # Subscription state of the contact. Allowed values are Subscribed and Unsubscribed.
      #
      # @return [String]
      #
      def subscription_state
        hash['subscriptionState']
      end

      # Subscribe date of the contact.
      #
      # @return [DateTime]
      #
      def subscribe_date
        DateTime.strptime(hash["subscribeDate"], '%FT%T')
      end

      # Subscribe method of the contact.
      #
      # @return [String]
      #
      def subscribe_method
        hash['subscribeMethod']
      end

      # Unsubscribe date of the contact.
      #
      # @return [DateTime]
      #
      def unsubscribe_date
        DateTime.strptime(hash["unsubscribeDate"], '%FT%T')
      end

      # Unsubscribe method of the contact.
      #
      # @return [String]
      #
      def unsubscribe_method
        hash['unsubscribeMethod']
      end
    end
  end
end
