require 'test_helper'

module Workarea
  module Listrak
    class OauthTest < TestCase
      def test_token_with_valid_credentials
        VCR.use_cassette "listrak/oauth-successful" do
          token = Oauth.token(
            client_id: 'doyfni0aw64ogd84ld6t',
            client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5JU'
          )

          assert token.present?
        end
      end

      def test_token_with_invalid_credentials
        VCR.use_cassette "listrak/oauth-unsuccessful" do
          error = assert_raises Listrak::OauthError do
            Oauth.token(
              client_id: 'doyfni0aw64ogd84ld6t',
              client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5J'
            )
          end

          assert_equal({ error: "Invalid Credentials" }.to_json, error.message)
        end
      end

      def test_request_token_through_proxy_when_provided
        proxy = ENV['http_proxy']
        ENV['http_proxy'] = '127.0.0.1'

        assert_raises SocketError do
          Oauth.token(
            client_id: 'doyfni0aw64ogd84ld6t',
            client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5J'
          )
        end
      ensure
        ENV['http_proxy'] = proxy
      end
    end
  end
end
