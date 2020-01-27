module Workarea
  module Listrak
    module Oauth
      # Generates an oauth token for a client_id and client_secret.
      #
      # @param client_id [String] client id
      # @param client_secret [String] client secret
      # @raise [OauthError] raised if generating an Oauth token is unsucessful
      # @return [String] Oauth token
      def self.token(client_id:, client_secret:)
        cache_key = "listrak/api/#{client_id}"
        token = Rails.cache.read(cache_key)

        return token if token.present?

        payload = {
          grant_type: 'client_credentials',
          client_id: client_id,
          client_secret: client_secret
        }
        response = http.post('/OAuth2/Token', payload.to_json)

        case response
        when ::Net::HTTPSuccess
          body = JSON.parse response.body
          token = body["access_token"]
          expiry = body["expires_in"] - 60

          Rails.cache.write(cache_key, token, expires_in: expiry)
          token
        else
          raise OauthError.new response
        end
      end

      def self.http
        @http ||= Net::HTTP.new('auth.listrak.com', 443).tap do |client|
          client.use_ssl = true
        end
      end
    end
  end
end
