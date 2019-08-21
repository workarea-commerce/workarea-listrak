module Workarea
  module Listrak
    class EmailApi::Events
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Returns the collection of events associated with the specified list.
      #
      # @param [Integer] list_id the list id to get the events from
      #
      # @raise [OauthError] raised if generating an Oauth token is unsucessful
      #
      # @return [Array<Workarea::Listrak::Models::Event>] Litrak events for the list
      #
      def all(list_id)
        request = Net::HTTP::Get.new("/email/v1/List/#{list_id}/Event")
        response = client.request request
        body = JSON.parse(response.body)
        body["data"].map { |event| Listrak::Models::Event.new event }
      end

      # Creates a new event on the specified list.
      #
      # @param [Integer] list_id the list id to create the event under
      # @param [Workarea::Listrak::Models::EventForm] event to create
      #
      # @raise [OauthError] raised if generating an Oauth token is unsucessful
      #
      # @return [String] resource id
      #
      def create(list_id, event)
        request = Net::HTTP::Post.new("/email/v1/List/#{list_id}/Event").tap do |post|
          post.body = event.to_json
        end
        response = client.request request
        body = JSON.parse(response.body)
        body["resourceId"]
      end
    end
  end
end
