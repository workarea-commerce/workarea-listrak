require 'test_helper'

module Workarea
  module Listrak
    class EmailApi::EventsTest < TestCase
      def test_create
        VCR.use_cassette 'listrak/email_api/events_create-successful' do
          event = Listrak::Models::EventForm.new(
            name: "footer signup"
          )

          response = email_api.events.create(349984, event)
          assert response.present?
        end
      end

      def test_create_invalid_parameter
        VCR.use_cassette 'listrak/email_api/events_create-invalid_parameter' do
          event = Listrak::Models::EventForm.new(
            name: "footer signup"
          )

          error = assert_raises Workarea::Listrak::HttpError do
            email_api.events.create(349984, event)
          end

          assert_equal "ERROR_INVALID_PARAMETER", error.error_code
          assert_equal "An invalid value was supplied for eventName.", error.api_message
        end
      end

      def test_all
        VCR.use_cassette 'listrak/email_api/events_get-successful' do
          events = email_api.events.all(349984)

          assert_equal [12714, 12715], events.map(&:id)
          assert_equal ["Test", "footer signup"], events.map(&:name)
          assert_equal [0, 0], events.map(&:group_id)
          assert_equal ["Active", "Active"], events.map(&:status)
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
