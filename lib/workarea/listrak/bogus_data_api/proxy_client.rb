module Workarea
  module Listrak
    class BogusDataApi
      class ProxyClient
        attr_reader :client_name, :client

        def initialize(client_name, client)
          @client_name = client_name
          @client = client
        end

        def method_missing(method, *args)
          if client.respond_to?(method)
            if BogusDataApi.store_requests
              BogusDataApi.requests[client_name][method] << args
            end
            client.send(method, *args)
          else
            super
          end
        end

        def respond_to_missing?(method, include_all = false)
          client.respond_to?(method) || super
        end
      end
    end
  end
end
