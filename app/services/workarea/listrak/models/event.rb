module Workarea
  module Listrak
    module Models
      class Event
        attr_reader :hash

        def initialize(hash)
          @hash = hash
        end

        # Identifier used to locate the event.
        #
        # @return [Integer]
        #
        def id
          hash["eventId"]
        end

        # Name given to the event.
        #
        # @return [String]
        #
        def name
          hash["eventName"]
        end

        # Identifier of the event group associated with the event.
        #
        # @return [Integer]
        #
        def group_id
          hash["eventGroupId"]
        end

        # Status of the event. Allowed values are Active and Blocked.
        #
        # @return [String]
        #
        def status
          hash["status"]
        end
      end
    end
  end
end
