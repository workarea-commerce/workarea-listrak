module Workarea
  module Listrak
    # A Transactional Message resource provides a way to access transactional
    # messages that have been created on a list.
    #
    class EmailApi::TransactionalMessages
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Sends a message based on a previously-created transactional message.
      #
      # @param [Integer] list_id Identifier used to locate the list
      # @param [Integer] message_id Identifier used to locate the transactional message.
      # @param [Workarea::Listrak::Models::TransactionalMessageForm] transactional_message_form
      #
      # @return [String] resource id
      #
      def create(list_id, message_id, transactional_message_form)
        path = "/email/v1/List/#{list_id}/TransactionalMessage/#{message_id}/Message"
        request = Net::HTTP::Post.new(path).tap do |post|
          post.body = transactional_message_form.to_json
        end
        response = client.request request
        body = JSON.parse(response.body)
        body["resourceId"]
      end
    end
  end
end
