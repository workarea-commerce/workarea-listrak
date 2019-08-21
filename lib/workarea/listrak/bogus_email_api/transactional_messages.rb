module Workarea
  module Listrak
    class BogusEmailApi::TransactionalMessages
      def create(_list_id, _message_id, _transactional_message)
        return "1234556"
      end
    end
  end
end
