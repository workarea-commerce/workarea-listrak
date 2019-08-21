module Workarea
  module Listrak
    module Models
      class MessageForm
        attr_reader :options

        def initialize(from_email:, from_name:, subject:, **options)
          @from_email = from_email
          @from_name = from_name
          @subject = subject
          @options = options.symbolize_keys
        end

        def to_json
          {
            campaignId: campaign_id,
            bodyHtml: body_html,
            bodyText: body_text,
            codePage: code_page,
            enablePassalong: enable_passalong,
            enableTracking: enable_tracking,
            fromEmail: from_email,
            fromName: from_name,
            googleAnalyticsCampaignName: google_analytics_campaign_name,
            googleAnalyticsCampaignContent: google_analytics_campaign_content,
            replyEmail: reply_email,
            savedAudienceId: save_audience_id,
            subject: subject,
            toName: to_name
          }.compact.to_json
        end

        # Identifier of the campaign associated with the message.
        #
        # @return [Integer]
        #
        def campaign_id
          options[:campaign_id]
        end

        # HTML body that will be sent in the message.
        #
        # @return [String]
        #
        def body_html
          options[:body_html]
        end

        # Text body that will be sent in the message.
        #
        # @return [String]
        #
        def body_text
          options[:body_text]
        end

        # Type of CodePage used in the message.
        #
        # @return [Integer]
        #
        def code_page
          options[:code_page]
        end

        # Whether passalong is enabled.
        #
        # @return [Boolean]
        #
        def enable_passalong
          options[:enable_passalong]
        end

        # Whether tracking is enabled.
        #
        # @return [Boolean]
        #
        def enable_tracking
          options[:enable_tracking]
        end

        # The from email address that will be used for the message.
        #
        # @return [String]
        #
        def from_email
          @from_email
        end

        # The from name that will be used for the message.
        #
        # @return [String]
        #
        def from_name
          @from_name
        end

        # The Google Analytics campaign name to be used for message tracking.
        #
        # @return [String]
        #
        def google_analytics_campaign_name
          options[:google_analytics_campaign_name]
        end

        # The Google Analytics campaign content to be used for message tracking.
        #
        # @return [String]
        #
        def google_analytics_campaign_content
          options[:google_analytics_campaign_content]
        end

        # The reply email address that will be used for the message.
        #
        # @return [String]
        #
        def reply_email
          options[:reply_email]
        end

        # Identifier of the SavedAudience to use for recipient filtering.
        #
        # @return [Integer]
        #
        def save_audience_id
          options[:save_audience_id]
        end

        # Subject of the message.
        #
        # @return [String]
        #
        def subject
          @subject
        end

        # The to name that will be used for the message.
        #
        # @return [String]
        #
        def to_name
          options[:to_name]
        end
      end
    end
  end
end
