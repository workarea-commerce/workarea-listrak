module Workarea
  module Admin
    module Listrak
      class ConfigurationsController < Admin::ApplicationController
        def edit
          @configuration = ListrakConfigurationViewModel.new(
            Workarea::Listrak.configuration
          )
        end

        def update
          configuration = Workarea::Listrak.configuration
          if configuration.update_attributes(configuration_params)
            redirect_to admin.edit_listrak_configuration_path, flash: { success: t('workarea.admin.listrak_configuration.edit.flash_messages.updated') }
          else
            flash[:error] = t('workarea.admin.listrak_configuration.edit.flash_messages.save_error')
            @configuration = ListrakConfigurationViewModel.new(configuration)
            render :edit, status: :unprocessable_entity
          end
        end

        private

          def configuration_params
            params.permit(:default_list_id, external_event_ids: [])
          end
      end
    end
  end
end
