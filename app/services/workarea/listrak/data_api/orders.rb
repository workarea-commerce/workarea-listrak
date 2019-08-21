module Workarea
  module Listrak
    class DataApi::Orders
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Starts a new import using the supplied order collection.
      #
      # @param [Array<Workarea::Listrak::Models::OrderForm>] orders array of orders to import
      #
      # @return [String] resource id
      #
      def import(orders)
        request = Net::HTTP::Post.new("/data/v1/Order").tap do |post|
          post.body = orders.to_json
        end
        response = client.request request
        body = JSON.parse(response.body)
        body["resourceId"]
      end
    end
  end
end
