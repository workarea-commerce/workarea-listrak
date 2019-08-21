require 'test_helper'

module Workarea
  class ListrakSystemTest < SystemTest
    include Listrak::VcrConfig

    def test_signing_up_in_footer_adds_to_default_list
      VCR.use_cassette 'listrak/system_tests/footer_email_signup-successful' do
        create_listrak_configuration(default_list_id: '349984', external_event_ids: [12714])

        visit storefront.root_path

        fill_in :footer_email_signup_field, with: 'epigeon@weblinc.com'
        click_button t('workarea.storefront.users.join')

        contact = email_api.contacts.get('349984', 'epigeon@weblinc.com')
        assert_equal 'Subscribed', contact.subscription_state
      end
    end

    def test_signing_up_in_footer_overrides_unsubscribe
      VCR.use_cassette 'listrak/system_tests/footer_email_signup_overrides_unsubscribe' do
        create_listrak_configuration(default_list_id: '349984')
        contact = Listrak::Models::ContactForm.new(
          email: 'customer@workarea.com',
          subscription_state: 'Unsubscribed'
        )

        email_api.contacts.upsert(349984, contact)

        visit storefront.root_path

        fill_in :footer_email_signup_field, with: 'customer@weblinc.com'
        click_button t('workarea.storefront.users.join')

        contact = email_api.contacts.get('349984', 'customer@weblinc.com')
        assert_equal 'Subscribed', contact.subscription_state
      end
    end

    def test_unsubscribbing_from_account
      VCR.use_cassette 'listrak/system_tests/unsubscribing' do
        create_listrak_configuration(default_list_id: '349984')
        visit storefront.login_path

        fill_in :create_account_email, with: 'employee+2@weblinc.com'
        fill_in :create_account_password, with: 'W3bl1nc!'
        check :email_signup

        click_button :create_account

        assert_current_path(storefront.users_account_path)

        contact = email_api.contacts.get('349984', 'employee+2@weblinc.com')
        assert_equal 'Subscribed', contact.subscription_state

        visit storefront.edit_users_account_path

        uncheck :email_signup

        click_button :save_info

        contact = email_api.contacts.get('349984', 'employee+2@weblinc.com')
        assert_equal 'Unsubscribed', contact.subscription_state
      end
    end

    private

      def email_api
        @email_api ||= Listrak::EmailApi.new client_id: 'doyfni0aw64ogd84ld6t',
          client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5JU'
      end
  end
end
