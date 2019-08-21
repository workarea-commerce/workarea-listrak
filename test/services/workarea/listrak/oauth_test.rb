require 'test_helper'

module Workarea
  module Listrak
    class OauthTest < TestCase
      def test_token_with_valid_credentials
        VCR.use_cassette "listrak/oauth-successful" do
          token = Oauth.token client_id: 'doyfni0aw64ogd84ld6t',
            client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5JU'

          assert token.present?
        end
      end

      def test_token_with_invalid_credentials
        VCR.use_cassette "listrak/oauth-unsuccessful" do
          error = assert_raises Listrak::OauthError do
            Oauth.token client_id: 'doyfni0aw64ogd84ld6t',
              client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5J'
          end

          assert_equal({ error: "Invalid Credentials" }.to_json, error.message)
        end
      end
    end
  end
end
