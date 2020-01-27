module Workarea
  module Listrak
    module Oauth
      # Generates an oauth token for a client_id and client_secret.
      #
      # @param client_id [String] client id
      # @param client_secret [String] client secret
      # @param options [Hash] extra options when getting the OAuth token
      # @option options [Integer] timeout value for open and read timeouts
      # @option options [Integer] open_timeout value for open timeout
      # @option options [Integer] read_timeout value for read timeout
      #
      # @raise [OauthError] raised if generating an Oauth token is unsucessful
      #
      # @return [String] Oauth token
      def self.token(client_id:, client_secret:, **options)
        cache_key = "listrak/api/#{client_id}"
        token = Rails.cache.read(cache_key)

        return token if token.present?

        uri = URI('https://auth.listrak.com/OAuth2/Token')
        params = {
          grant_type: 'client_credentials',
          client_id: client_id,
          client_secret: client_secret
        }

        response = Net::HTTP.post_form uri, params

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
    end
  end
end
