module Workarea
  module Listrak
    module Models
      class EventForm
        STATUSES = ['Active', 'Blocked']
        attr_reader :name, :status, :group_ip, :options

        def initialize(name:, status: nil, group_ip: nil, **options)
          @name = name
          @status = status.presence_in(STATUSES) || STATUSES.first
          @group_ip = group_ip
          @options = options
        end

        def to_json
          {
            eventName: name,
            eventGroupId: group_ip,
            status: status
          }.compact.to_json
        end
      end
    end
  end
end
