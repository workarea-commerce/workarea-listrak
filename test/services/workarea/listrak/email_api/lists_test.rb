require 'test_helper'

module Workarea
  module Listrak
    class EmailApi::ListsTest < TestCase
      def test_all
        VCR.use_cassette 'listrak/email_api/lists_all-successful' do
          lists = email_api.lists.all
          assert_equal 2, lists.size
          assert_equal [349956, 349984], lists.map(&:id)
          assert_equal ["My First List", "gem-testing"], lists.map(&:name)
          assert_equal [0, 0], lists.map(&:folder_id)
          assert_equal [11, 11], lists.map(&:ip_pool_id)
          assert_equal ["", ""], lists.map(&:bounce_domain_alias)
          assert_equal ["Standard", "Standard"], lists.map(&:bounce_handling)
          assert_equal [5, 5], lists.map(&:bounce_unsubscribe_count)
          assert_equal [DateTime.strptime("2015-08-31T16:02:41.65", "%FT%T"), DateTime.strptime("2015-09-02T14:42:38.91", "%FT%T")], lists.map(&:create_date)
          assert_equal [false, false], lists.map(&:enable_browser_link)
          assert_equal [false, false], lists.map(&:enable_double_opt_in)
          assert_equal [false, false], lists.map(&:enable_dynamic_content)
          assert_equal [false, false], lists.map(&:enable_google_analytics)
          assert_equal [false, false], lists.map(&:enable_internationalization)
          assert_equal [true, true], lists.map(&:enable_list_hygiene)
          assert_equal [true, true], lists.map(&:enable_list_removal_header)
          assert_equal [true, true], lists.map(&:enable_list_removal_link)
          assert_equal [false, false], lists.map(&:enable_listrak_analytics)
          assert_equal [false, false], lists.map(&:enable_spam_score_personalization)
          assert_equal [false, false], lists.map(&:enable_to_name_personalization)
          assert_equal ["", "mac@weblinc.com"], lists.map(&:from_email)
          assert_equal ["", "WebLinc Developer"], lists.map(&:from_name)
          assert_equal [[], []], lists.map(&:google_tracking_domains)
          assert_equal ["", ""], lists.map(&:link_domain_alias)
          assert_equal ["", ""], lists.map(&:media_domain_alias)
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
