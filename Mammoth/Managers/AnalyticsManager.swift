//
//  AnalyticsManager.swift
//  Mammoth
//
//  Created by Terence on 10/3/23.
//  Copyright © 2023 The BLVD. All rights reserved.
//

import Foundation

enum Events: String {
    case newPost
    case newPostFailed
    case newReplyFailed
    case upgradedToGold
    case restoredToGold
    case failedToUpgrade
    case postBookmarked
    case channelSubscribed
    case channelUnsubscribed
    case navigateToChannel
    
    case loggedIn
    case accountCreated
    case verifiedEmail
    case switchingAccount
    
    case follow
    case unfollow
    
    case like
    case unlike
    case repost
    case unrepost
}

@available(*, deprecated, message: "Don't analytics")
class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    init() {

    }
    
    func prepareForUse() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSwitchAccount), name: didSwitchCurrentAccountNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdatePurchase), name: didUpdatePurchaseStatus, object: nil)
    }
    
    @objc func didSwitchAccount(_ notification: NSNotification) {
        // stub
    }
    
    @objc func didUpdatePurchase(_ notification: NSNotification) {
        // stub
    }
    
    private func callActivities() {
    }
    
    static public func track(event: Events, props: [String:Any]? = [:]) {

    }
    
    static public func reportError(_ error: Error) {

    }
    
    static public func identity(userId: String, identity: IdentityData) {

    }
    
    static public func alias(userId: String) {

    }
    
    static public func openURL(url: URL) {

    }
    
    static public func setDeviceToken(token: Data) {

    }
    
    static public func failedToRegisterForPushNotifications(error: Error?) {

    }
    
    static public func subscribe() {
    }
    
    static public func unsubscribe() {
    }
    
    static public func reset() {
    }
    
}
