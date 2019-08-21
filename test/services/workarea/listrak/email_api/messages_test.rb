require 'test_helper'

module Workarea
  module Listrak
    class EmailApi::MessagesTest < TestCase
      def test_create
        VCR.use_cassette 'listrak/email_api/messages_create-successful' do
          message = Listrak::Models::MessageForm.new(
            from_email: "plugins@workarea.com",
            from_name: "Plugins @ Workarea.com",
            subject: "Testing creating a message",
            body_html: "This is the body"
          )

          response = email_api.messages.create(349984, message)
          assert response.present?
        end
      end

      private

        def email_api
          @email_api ||= Listrak::EmailApi.new client_id: 'doyfni0aw64ogd84ld6t',
            client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5JU'
        end
    end
  end
end
