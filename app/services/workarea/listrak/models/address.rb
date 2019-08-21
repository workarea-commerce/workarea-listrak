module Workarea
  module Listrak
    module Models
      class Address
        attr_reader :workarea_address

        def initialize(workarea_address)
          @workarea_address = workarea_address
        end

        def as_json
          {
            address1: address1,
            address2: address2,
            address3: address3,
            city: city,
            country: country,
            state: state
          }.compact
        end

        # Home address line 1
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def address1
          workarea_address.street.to_s[0...100]
        end

        # Home address line 2
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def address2
          workarea_address.street_2.to_s[0..100]
        end

        # Home address line 3
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def address3
        end

        # Home address city
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def city
          workarea_address.city.to_s[0...100]
        end

        # Home address country
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def country
          workarea_address.country.name[0...100]
        end

        # Home address state
        #
        # limited to 100 characters
        #
        # @return [String]
        #
        def state
          workarea_address.region.to_s[0...100]
        end
      end
    end
  end
end
