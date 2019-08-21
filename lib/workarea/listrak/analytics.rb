module Workarea
  module Listrak
    module Analytics
      # Shorthand for analytics module specific configuration.
      def self.config
        Workarea.config.listrak.analytics
      end

      def self.javascript_config
        {
          merchantId: config[:merchant_id],
          emailIds: config[:email_capture_ids]
        }.compact.to_json
      end
    end
  end
end
