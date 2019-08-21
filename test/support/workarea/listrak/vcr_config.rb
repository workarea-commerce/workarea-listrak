module Workarea
  module Listrak
    module VcrConfig
      def self.included(test)
        super
        test.setup :setup_listrak_secrets
        test.teardown :restore_listrak_secrets
      end

      private

        def setup_listrak_secrets
          @_old_secrets = Rails.application.secrets.listrak
          Rails.application.secrets.listrak = {
            data_api: {
              client_id: 'a',
              client_secret: 'ZMOhwRN2MhkP0xicWzcu1rtEY9sjDUq/reVovZOY41U'
            },
            email_api: {
              client_id: 'doyfni0aw64ogd84ld6t',
              client_secret: 'LxdEE4Gu4aSJv5tS9osd8WudjGbJ+EIPYvZBS7bc5JU'
            }
          }
        end

        def restore_listrak_secrets
          Rails.application.secrets.listrak = @_old_secrets
        end
    end
  end
end
