module Workarea
  module Listrak
    module Models
      class CustomerForm
        GENDERS = ['M', 'F', 'Male', 'Female']

        # @param [Workarea::User] user to create a customer
        #
        def initialize(user)
          @user = user
        end

        def as_json(_options)
          {
            address: address,
            birthday: birthday,
            customerNumber: customer_number,
            email: email,
            firstName: first_name,
            gender: gender,
            homePhone: home_phone,
            lastName: last_name,
            meta1: meta1,
            meta2: meta2,
            meta3: meta3,
            meta4: meta4,
            meta5: meta5,
            mobilePhone: mobile_phone,
            preferredStoreNumber: preferred_store_number,
            registered: registered,
            workPhone: work_phone,
            zipCode: zip_code
          }.compact
        end

        private

          attr_reader :user

          # Address of customer
          #
          # @return [Workarea::Listrak::Models::Address]
          #
          def address
            return unless user.default_billing_address.present?

            Listrak::Models::Address.new(user.default_billing_address)
          end

          # Customer birthdate
          #
          # @return [String] birthday DateTime in %FT%TZ
          #
          def birthday
          end

          # Internal customer number
          #
          # limited to 20 characters
          #
          # @return [String]
          #
          def customer_number
            user.id.to_s[0...20]
          end

          # Email address of customer. This property is required for accounts
          # that are not CRM enabled.
          #
          # limited to 100 characters
          #
          # @return [String]
          #
          def email
            user.email.to_s[0...100]
          end

          # First name
          #
          # limited to 50 characters
          #
          # @return [String]
          #
          def first_name
            user.first_name
          end

          # Gender of customer
          #
          # limited to 50 characters
          #
          # @return [String]
          #
          def gender
          end

          # Landline phone number
          #
          # limted to 50 characters
          #
          # @return [String]
          #
          def home_phone
            user.default_billing_address&.phone_number
          end

          # Last name
          #
          # limited to 50 characters
          #
          # @return [String]
          #
          def last_name
            user.last_name
          end

          # Additional meta imformation
          #
          # limted to 250 characters
          #
          # @return [String]
          #
          def meta1
          end

          # Additional meta imformation
          #
          # limted to 250 characters
          #
          # @return [String]
          #
          def meta2
          end

          # Additional meta imformation
          #
          # limted to 250 characters
          #
          # @return [String]
          #
          def meta3
          end

          # Additional meta imformation
          #
          # limted to 250 characters
          #
          # @return [String]
          #
          def meta4
          end

          # Additional meta imformation
          #
          # limted to 250 characters
          #
          # @return [String]
          #
          def meta5
          end

          # Mobile phone number
          #
          # limited to 50 characters
          #
          # @return [String]
          def mobile_phone
            user.default_billing_address&.phone_number
          end

          # Preferred brick and mortar store location
          #
          # limited to 100 characters
          #
          # @return [String]
          #
          def preferred_store_number
          end

          # Indicates the customer registration state
          #
          # @return [Boolean]
          #
          def registered
            true
          end

          # Work phone number
          #
          # limited to 50 characters
          #
          # @return [String]
          #
          def work_phone
          end

          # Customer ZIP Code
          #
          # limited to 50 characters
          #
          # @return [String]
          #
          def zip_code
            user.default_billing_address&.postal_code
          end
      end
    end
  end
end
