module Workarea
  module Listrak
    class BogusEmailApi::Events
      def all(_list_id)
        events = [
          {
            "eventId" => 12714,
            "eventName" => "Test",
            "eventGroupId" => 0,
            "status" => "Active"
          },
          {
            "eventId" => 12715,
            "eventName" => "footer signup",
            "eventGroupId" => 0,
            "status" => "Active"
          }
        ]
        events.map { |event| Listrak::Models::Event.new event }
      end
    end
  end
end
