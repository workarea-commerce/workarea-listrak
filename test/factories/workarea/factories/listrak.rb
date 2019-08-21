module Workarea
  module Factories
    module Listrak
      Factories.add self

      def create_listrak_configuration(overrides = {})
        attributes = {
          default_list_id: '349984'
        }.merge overrides

        Workarea::Listrak::Configuration.create! attributes
      end
    end
  end
end
