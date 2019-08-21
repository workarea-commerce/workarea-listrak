require 'test_helper'

module Workarea
  module Listrak
    class EmailApi::ContactsTest < TestCase
      def test_upsert
        VCR.use_cassette 'listrak/email_api/contacts_upsert-successful' do
          contact = Listrak::Models::ContactForm.new(
            email: 'customer+new@workarea.com',
            subscription_state: 'Subscribed'
          )

          email_api.contacts.upsert(349984, contact)
        end
      end

      def test_upsert_already_unsubscribed
        VCR.use_cassette 'listrak/email_api/contacts_upsert-already_unsubscribed' do
          contact = Listrak::Models::ContactForm.new(
            email: 'customer@workarea.com',
            subscription_state: 'Subscribed'
          )

          error = assert_raises Workarea::Listrak::HttpError do
            email_api.contacts.upsert(349984, contact)
          end

          assert_equal "ERROR_UNSUBSCRIBED_EMAIL_ADDRESS", error.error_code
          assert_equal "The emailAddress has already been unsubscribed from the list.", error.api_message
        end
      end

      def test_get
        VCR.use_cassette 'listrak/email_api/contacts_get-successful' do
          contact = email_api.contacts.get(349984, "customer@workarea.com")

          assert_equal "customer@workarea.com", contact.email_address
          assert_equal "E423056525030584442F94FD29", contact.email_key
          assert_equal "Unsubscribed", contact.subscription_state
          assert_equal DateTime.parse("2018-12-14T14:31:55", "%FT%T"), contact.subscribe_date
          assert_nil contact.subscribe_method
          assert_equal DateTime.parse("2018-12-15T13:15:01", "%FT%T"), contact.unsubscribe_date
          assert_equal "Administrator", contact.unsubscribe_method
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
