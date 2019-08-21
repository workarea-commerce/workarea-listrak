module Workarea
  module Listrak
    class Configuration
      include ApplicationDocument

      # @!attribute default_list_id
      #   @return [Integer] list id customers are subscribed to
      #
      field :default_list_id, type: String

      # @!attribute external_event_ids
      #   @return [Array<Integer>] event ids to trigger when subscribing a customer
      #
      field :external_event_ids, type: Array

      validates_presence_of :default_list_id
    end
  end
end
