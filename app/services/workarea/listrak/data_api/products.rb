module Workarea
  module Listrak
    class DataApi::Products
      attr_reader :client

      def initialize(client)
        @client = client
      end

      # Starts a new import using the supplied product collection.
      #
      # @param [Array<Workarea::Listrak::Models::ProductForm>] products array of products to import
      #
      # @return [String] resource id
      #
      def import(products)
        request = Net::HTTP::Post.new("/data/v1/Product").tap do |post|
          post.body = products.to_json
        end
        response = client.request request
        body = JSON.parse(response.body)
        body["resourceId"]
      end
    end
  end
end
