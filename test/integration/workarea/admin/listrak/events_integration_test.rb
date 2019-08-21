require 'test_helper'

module Workarea
  module Admin
    module Listrak
      class EventsIntegrationTest < Workarea::IntegrationTest
        include Admin::IntegrationTest

        def test_index
          get admin.listrak_list_events_path list_id: "1234", format: :json
          assert response.ok?

          expected_json = {
            "results" => [{ "label" => "Test", "value" => 12714 }, { "label" => "footer signup", "value" => 12715 }]
          }
          assert_equal expected_json, JSON.parse(response.body)
        end
      end
    end
  end
end
