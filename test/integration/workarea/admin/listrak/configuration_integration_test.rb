require 'test_helper'

module Workarea
  module Admin
    module Listrak
      class ConfigurationIntegrationTest < Workarea::IntegrationTest
        include Admin::IntegrationTest

        def test_update
          create_listrak_configuration

          patch admin.listrak_configuration_path, params: { default_list_id: 1234 }
          assert_equal t('workarea.admin.listrak_configuration.edit.flash_messages.updated'), flash[:success]
          assert_redirected_to admin.edit_listrak_configuration_path
        end

        def test_update_with_invalid_params
          create_listrak_configuration

          patch admin.listrak_configuration_path, params: { default_list_id: nil }
          assert_equal "422", response.code
        end
      end
    end
  end
end
