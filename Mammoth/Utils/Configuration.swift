import Foundation

#warning("Use with Caution")
//TODO: Clean !
enum Configuration {

    private enum Keys {
        static let SwiftyGiphyAPI = "SWIFTY_GIPHY_API"
        static let InstanceSocialAPI = "INSTANCE_SOCIAL_API"
        static let IapVerificationSecret = "IAP_VERIFICATION_SECRET"
        static let JoinCommunityPageURL = "JOIN_COMMUNITY_PAGE_URL"
        static let CrowdinDistributionString = "CROWDIN_DISTRIBUTION_STRING"
        static let SubClubDomain = "SUB_CLUB_DOMAIN"

        static let PushNotificationURL = "PUSH_NOTIFICATION_URL"
        static let MothSocialSecretKey = "MOTH_SOCIAL_SECRET_KEY"
        static let ForYouEndpoint = "FOR_YOU_ENDPOINT"
    }

    public static var SwiftyGiphyAPI: String {
        return Bundle.main.infoDictionary![Keys.SwiftyGiphyAPI] as! String
    }

    public static var InstanceSocialAPI: String {
        return Bundle.main.infoDictionary![Keys.InstanceSocialAPI] as! String
    }

    public static var IapVerificationSecret: String {
        return Bundle.main.infoDictionary![Keys.IapVerificationSecret] as! String
    }

    public static var JoinCommunityPageURL: String {
        return "https://\(Bundle.main.infoDictionary![Keys.JoinCommunityPageURL] as! String)"
    }

    public static var CrowdinDistributionString: String {
        return Bundle.main.infoDictionary![Keys.CrowdinDistributionString] as! String
    }

    public static var SubClubDomain: String {
        return Bundle.main.infoDictionary![Keys.SubClubDomain] as! String
    }

    public static var PushNotificationURL: String {
        return "https://\(Bundle.main.infoDictionary![Keys.PushNotificationURL] as! String)"
    }

    public static var MothSocialSecretKey: String {
        return Bundle.main.infoDictionary![Keys.MothSocialSecretKey] as! String
    }

    public static var ForYouEndpoint: String {
        return Bundle.main.infoDictionary![Keys.ForYouEndpoint] as! String
    }


}
