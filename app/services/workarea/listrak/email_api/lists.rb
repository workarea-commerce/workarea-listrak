module Workarea
  module Listrak
    class EmailApi::Lists
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Get all lists in Listrak
      #
      # @return [Array<Workarea::Listrak::Models::List>] Listrak lists
      def all
        request = Net::HTTP::Get.new("/email/v1/List")
        response = client.request request
        body = JSON.parse(response.body)
        body["data"].map { |list| Listrak::Models::List.new list }
      end
    end
  end
end
