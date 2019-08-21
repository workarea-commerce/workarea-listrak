require "workarea"
require "workarea/core"
require "workarea/storefront"
require "workarea/admin"

require "workarea/listrak/version"
require "workarea/listrak/engine"

require "workarea/listrak/error"
require "workarea/listrak/analytics"

require "workarea/listrak/bogus_email_api"
require "workarea/listrak/bogus_data_api"

module Workarea
  # Workarea integration with the Listrak service.
  module Listrak
    def self.credentials
      (Rails.application.secrets.listrak || {}).deep_symbolize_keys
    end

    def self.configuration
      Listrak::Configuration.first || Listrak::Configuration.new
    end

    def self.email(timeout: nil, open_timeout: nil, read_timeout: nil)
      open_timeout ||= timeout
      read_timeout ||= timeout
      if credentials.dig(:email_api, :client_id) && credentials.dig(:email_api, :client_secret)
        Listrak::EmailApi.new(credentials[:email_api].merge(open_timeout: open_timeout, read_timeout: read_timeout))
      else
        Listrak::BogusEmailApi.new
      end
    end

    # An instance of the Listrak Data Api
    #
    # If the required data api credentials are present an instance of Workarea::Listrak::EmailApi
    # is returned otherwise an instance of Workarea::Listrak::BogusEmailApi is returned
    #
    # @param [Integer] timeout value for open timeout and read timeoue
    # @param [Integer] open_timeout value for open timeout
    # @param [Integer] read_timeout value for read timeout
    #
    # @return [Workarea::Listrak::EmailApi, Workarea::Listrak::BogusEmailApi] an instance of the data api
    #
    def self.data(timeout: nil, open_timeout: nil, read_timeout: nil)
      open_timeout ||= timeout
      read_timeout ||= timeout
      if credentials.dig(:data_api, :client_id) && credentials.dig(:email_api, :client_secret)
        Listrak::DataApi.new(credentials[:data_api].merge(open_timeout: open_timeout, read_timeout: read_timeout))
      else
        Listrak::BogusDataApi.new
      end
    end
  end
end
