module Workarea
  module Listrak
    # @!visibility private
    class BogusDataApi
      require 'workarea/listrak/bogus_data_api/proxy_client'
      require 'workarea/listrak/bogus_data_api/products'
      require 'workarea/listrak/bogus_data_api/customers'
      require 'workarea/listrak/bogus_data_api/orders'

      thread_cattr_accessor :requests, :store_requests

      def self.reset_requests!
        self.requests = Hash.new do |client_hash, client_class|
          client_hash[client_class] = Hash.new do |method_hash, method_name|
            method_hash[method_name] = []
          end
        end
      end

      def self.total_request_count
        self.requests.sum do |client, method_calls|
          method_calls.sum { |_method, calls| calls.size }
        end
      end

      self.store_requests = false
      self.reset_requests!

      def method_missing(method)
        client_class = client(method)

        if client_class
          ProxyClient.new(method, client_class.new)
        else
          super
        end
      end

      private

        def client(client_name)
          BogusDataApi.const_get(client_name.to_s.camelize) rescue nil
        end
    end
  end
end
