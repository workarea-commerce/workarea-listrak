module Workarea
  module Listrak
    # @!visibility private
    class BogusEmailApi
      require 'workarea/listrak/bogus_email_api/proxy_client'
      require 'workarea/listrak/bogus_email_api/contacts'
      require 'workarea/listrak/bogus_email_api/events'
      require 'workarea/listrak/bogus_email_api/lists'
      require 'workarea/listrak/bogus_email_api/transactional_messages'

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

      def respond_to_missing?(method, include_all = false)
        client(method).present? || super
      end

      private

        def client(client_name)
          BogusEmailApi.const_get(client_name.to_s.camelize) rescue nil
        end
    end
  end
end
