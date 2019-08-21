module Workarea
  module Listrak
    class DataApi
      def initialize(client_id:, client_secret:, open_timeout: nil, read_timeout: nil)
        @client_id = client_id
        @client_secret = client_secret
        @open_timeout = open_timeout
        @read_timeout = read_timeout
      end

      def request(http_request)
        token = Listrak::Oauth.token(client_id: client_id, client_secret: client_secret)

        http_request.add_field 'Authorization', "Bearer #{token}"
        http_request.add_field 'Content-Type', 'application/json'
        http_request['Accept'] = 'application/json'

        response = http.start do |conn|
          conn.request http_request
        end

        case response
        when ::Net::HTTPSuccess
          response
        else
          raise Listrak::HttpError, response
        end
      end

      def customers
        Customers.new self
      end

      def orders
        Orders.new self
      end

      def products
        Products.new self
      end

      private

        attr_reader :client_id, :client_secret, :open_timeout, :read_timeout

        def http
          Net::HTTP.new(uri.host, uri.port).tap do |conn|
            conn.use_ssl = true
            conn.read_timeout = read_timeout if read_timeout
            conn.open_timeout = open_timeout if open_timeout
          end
        end

        def base_url
          "https://api.listrak.com/email/"
        end

        def uri
          URI base_url
        end
    end
  end
end
