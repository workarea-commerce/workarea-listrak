module Workarea
  module Listrak
    class EmailApi::Messages
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Sends a new message on the specified list.
      #
      # @param [String] list_id the list to send the message
      # @param [Workarea::Listrak::Models::MessageForm] message to send
      # @param [Hash] options extra options when sending the message
      # @option options [String] sendDate the send date for the message
      # @option options [Boolean] sendTestMessage whether a test message should be sent. default false
      # @option options [Boolean] sendReviewMessage whether a review message should be sent. default false
      # @option options [String] testEmailAddress test email address that will be used to preview the scheduled message
      #
      def create(list_id, message, **options)
        params = validate_query_params(options, create_params)
        params = {}.to_param
        path = ["/email/v1/List/#{list_id}/Message", params].compact.join '?'
        request = Net::HTTP::Post.new(path).tap do |post|
          post.body = message.to_json
        end
        response = client.request request
        body = JSON.parse(response.body)
        body["resourceId"]
      end

      private

        def validate_query_params(hash, valid_params)
          hash.select do |key, value|
            valid_params[key] && value.is_a?(valid_params[key])
          end.to_param.presence
        end

        def create_params
          {
            sendDate: String,
            sendTestMessage: Boolean,
            sendReviewMessage: Boolean,
            testEmailAddress: String
          }
        end
    end
  end
end
