module Workarea
  module Listrak
    class Error < StandardError; end

    class OauthError < Listrak::Error
      attr_reader :http_response

      def initialize(http_response)
        @http_response = http_response
        super(http_response.body)
      end

      def body
        @body ||= JSON.parse(http_response.body) rescue nil
      end
    end

    class HttpError < StandardError
      attr_reader :http_response

      def initialize(http_response)
        @http_response = http_response
        super(http_response.body)
      end

      def body
        @body ||= JSON.parse(http_response.body) rescue nil
      end

      def error_code
        body["error"] rescue nil
      end

      def api_message
        body["message"] rescue nil
      end
    end
  end
end
