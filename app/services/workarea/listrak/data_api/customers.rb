module Workarea
  module Listrak
    class DataApi::Customers
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Starts a new import using the supplied customer collection.
      #
      # @param [Array<Workarea::Listrak::Models::CustomerForm>] customers array of customers to import
      #
      # @return [String] resource_id
      #
      def import(customers)
        request = Net::HTTP::Post.new("/data/v1/Customer").tap do |post|
          post.body = customers.to_json
        end
        response = client.request request
        body = JSON.parse(response.body)
        body["resourceId"]
      end
    end
  end
end
