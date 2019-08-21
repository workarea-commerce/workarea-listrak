module Workarea
  module Admin
    module Listrak
      class EventsController < Admin::ApplicationController
        def index
          @events = Workarea::Listrak.email.events.all list_id
        end

        private

          def list_id
            params[:list_id]
          end
      end
    end
  end
end
