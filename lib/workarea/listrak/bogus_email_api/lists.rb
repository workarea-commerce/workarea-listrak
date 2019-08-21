module Workarea
  module Listrak
    class BogusEmailApi::Lists
      def all
        lists = [
          {
            "listId" => 349956,
            "listName" => "My First List",
            "folderId" => 0,
            "ipPoolId" => 11,
            "bounceDomainAlias" => "",
            "bounceHandling" => "Standard",
            "bounceUnsubscribeCount" => 5,
            "createDate" => "2015-08-31T16:02:41.65",
            "enableBrowserLink" => false,
            "enableDoubleOptIn" => false,
            "enableDynamicContent" => false,
            "enableGoogleAnalytics" => false,
            "enableInternationalization" => false,
            "enableListHygiene" => true,
            "enableListRemovalHeader" => true,
            "enableListRemovalLink" => true,
            "enableListrakAnalytics" => false,
            "enableSpamScorePersonalization" => false,
            "enableToNamePersonalization" => false,
            "fromEmail" => "",
            "fromName" => "",
            "googleTrackingDomains" => [],
            "linkDomainAlias" => "",
            "mediaDomainAlias" => ""
          },
          {
            "listId" => 349984,
            "listName" => "gem-testing",
            "folderId" => 0,
            "ipPoolId" => 11,
            "bounceDomainAlias" => "",
            "bounceHandling" => "Standard",
            "bounceUnsubscribeCount" => 5,
            "createDate" => "2015-09-02T14:42:38.91",
            "enableBrowserLink" => false,
            "enableDoubleOptIn" => false,
            "enableDynamicContent" => false,
            "enableGoogleAnalytics" => false,
            "enableInternationalization" => false,
            "enableListHygiene" => true,
            "enableListRemovalHeader" => true,
            "enableListRemovalLink" => true,
            "enableListrakAnalytics" => false,
            "enableSpamScorePersonalization" => false,
            "enableToNamePersonalization" => false,
            "fromEmail" => "mac@weblinc.com",
            "fromName" => "WebLinc Developer",
            "googleTrackingDomains" => [],
            "linkDomainAlias" => "",
            "mediaDomainAlias" => ""
          }
        ]
        lists.map { |list| Listrak::Models::List.new list }
      end
    end
  end
end
