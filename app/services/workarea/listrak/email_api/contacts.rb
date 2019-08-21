module Workarea
  module Listrak
    class EmailApi::Contacts

      attr_reader :client

      def initialize(client)
        @client = client
      end

      # @param [String] list_id the list to add this contact to
      # @param [Workarea::Listrak::Models::ContactForm] contact to create or update
      # @param [Hash] options extra options when upserting the contact
      # @option options [String] eventIds Comma-separated list of event identifiers that should be raised after the contact is created or updated.
      # @option options [Boolean] overrideUnsubscribe Whether a contact in an unsubscribed state should be forced to a subscribed state. The default value is false
      # @option options [Boolean] subscribedByContact Whether the subscribe was initiated by the contact. The default value is false.
      # @option options [Boolean] sendDoubleOptIn Whether a double opt-in email should be sent if a new contact is being created. The default value is false.
      # @option options [String] updateType If updating an existing contact, the type of update that will be performed on any submitted segmentation fields. Allowed values are Update, Append, and Overwrite. The default value is Update.
      # @option options [String] newEmailAddress If updating an existing contact, the contact's email address will be changed to this value. Provide the original email address in the emailAddress body field to select the existing contact.
      def upsert(list_id, contact, options = {})
        params = validate_query_params(options, upsert_params)
        path = ["/email/v1/List/#{list_id}/Contact", params].compact.join '?'
        request = Net::HTTP::Post.new(path).tap do |post|
          post.body = contact.to_json
        end
        response = client.request request
        body = JSON.parse(response.body)
        body["data"]
      end

      # @param [String] list_id Identifier used to locate the list.
      # @param [String] contactIdentifier dentifier used to locate the contact. You may specify either an email address or a Listrak email key.
      # @param [Hash] options extra options when getting the contact
      # @option options [String] segmentationFieldIds Comma-separated list of segmentation field IDs to retrieve. Up to 30 fields may be included.
      #
      # @return [Workarea::Listrak::Models::Contact]
      def get(list_id, contactIdentifier, options = {})
        params = validate_query_params(options, get_params)
        path = [
          "/email/v1/List/#{list_id}/Contact/#{contactIdentifier}",
          params
        ].compact.join '?'
        request = Net::HTTP::Get.new(path)
        response = client.request request
        body = JSON.parse response.body
        Listrak::Models::Contact.new(body["data"])
      end

      private

        def validate_query_params(hash, valid_params)
          hash.select do |key, value|
            valid_params[key] && value.is_a?(valid_params[key])
          end.to_param.presence
        end

        def upsert_params
          {
            eventIds:            String,
            overrideUnsubscribe: Boolean,
            subscribedByContact: Boolean,
            sendDoubleOptIn:     Boolean,
            updateType:          String,
            newEmailAddress:     String
          }
        end

        def get_params
          { 'segmentationFieldIds' => String }
        end
    end
  end
end
