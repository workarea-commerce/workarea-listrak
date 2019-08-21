module Workarea
  module Admin
    class ListrakConfigurationViewModel < ApplicationViewModel
      def all_lists
        @all_lists ||= Workarea::Listrak.email.lists.all
      end

      def event_options
        events.map { |event| [event.name, event.id] }
      end

      def events
        @events ||= Workarea::Listrak.email.events.all default_list_id
      end
    end
  end
end
