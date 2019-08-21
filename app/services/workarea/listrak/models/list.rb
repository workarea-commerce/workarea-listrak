module Workarea
  module Listrak
    module Models
      class List
        attr_reader :hash

        def initialize(hash)
          @hash = hash
        end

        # Identifier used to locate the list.
        #
        # @return [Integer]
        #
        def id
          hash["listId"]
        end

        # Name of the list.
        #
        # @return [String]
        #
        def name
          hash["listName"]
        end

        # Identifier of the folder associated with the list.
        #
        # @return [Integer]
        #
        def folder_id
          hash["folderId"]
        end

        # Identifier of the IP pool associated with the list.
        #
        # @return [Integer]
        #
        def ip_pool_id
          hash["ipPoolId"]
        end

        # Alias domain for email bounces.
        #
        # @return [String]
        #
        def bounce_domain_alias
          hash["bounceDomainAlias"]
        end

        # Bounce handling method for the list. Allowed values are None, Standard, and Aggressive.
        #
        # @return [String]
        #
        def bounce_handling
          hash["bounceHandling"]
        end

        # The number of bounces that are allowed before being automatically unsubscribed.
        #
        # @return [Integer]
        #
        def bounce_unsubscribe_count
          hash["bounceUnsubscribeCount"]
        end

        # The creation date of the list.
        #
        # @return [DateTime]
        #
        def create_date
          DateTime.strptime(hash["createDate"], '%FT%T')
        end

        # Whether browser link is enabled.
        #
        # @return [Boolean]
        #
        def enable_browser_link
          hash["enableBrowserLink"]
        end

        # Whether double opt-in is enabled.
        #
        # @return [Boolean]
        #
        def enable_double_opt_in
          hash["enableDoubleOptIn"]
        end

        # Whether dynamic content is enabled.
        #
        # @return [Boolean]
        #
        def enable_dynamic_content
          hash["enableDynamicContent"]
        end

        # Whether Google Analytics is enabled.
        #
        # @return [Boolean]
        #
        def enable_google_analytics
          hash["enableGoogleAnalytics"]
        end

        # Whether internationalization is enabled.
        #
        # @return [Boolean]
        #
        def enable_internationalization
          hash["enableInternationalization"]
        end

        # Whether list hygiene is enabled.
        #
        # @return [Boolean]
        #
        def enable_list_hygiene
          hash["enableListHygiene"]
        end

        # Whether unsubscribe information is automatically included in message headers.
        #
        # return [Boolean]
        #
        def enable_list_removal_header
          hash["enableListRemovalHeader"]
        end

        # Whether the list removal link is automatically included.
        #
        # @return [Boolean]
        #
        def enable_list_removal_link
          hash["enableListRemovalLink"]
        end

        # Whether Listrak Analytics is enabled.
        #
        # @return [Boolean]
        def enable_listrak_analytics
          hash["enableListrakAnalytics"]
        end

        # Whether personalization is available in Spam Score.
        #
        # @return [Boolean]
        #
        def enable_spam_score_personalization
          hash["enableSpamScorePersonalization"]
        end

        # Whether personalization is enabled for a recipient's To name.
        #
        # @return [Boolean]
        #
        def enable_to_name_personalization
          hash["enableToNamePersonalization"]
        end

        # The From email address used by default when sending messages.
        #
        # @return [String]
        #
        def from_email
          hash["fromEmail"]
        end

        # The From name used by default when sending messages.
        #
        # @return [String]
        #
        def from_name
          hash["fromName"]
        end

        # Google tracking domains of the list.
        #
        # @return [Array<String>]
        #
        def google_tracking_domains
          hash["googleTrackingDomains"]
        end

        # Alias domain for links in the list's messages.
        #
        # return [String]
        #
        def link_domain_alias
          hash["linkDomainAlias"]
        end

        # Alias domain for media in the list's messages.
        #
        # @return [String]
        #
        def media_domain_alias
          hash["mediaDomainAlias"]
        end
      end
    end
  end
end
