//
//  TimelineService.swift
//  Mammoth
//
//  Created by Benoit Nolens on 24/05/2023.
//  Copyright © 2023 The BLVD. All rights reserved.
//

import Foundation

enum TimelineType {
    case `public`
    case trending
}

struct TimelineService {
    
    static func home(range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Timelines.home(range: range)
        let result = try await ClientService.runRequest(request: request)
        return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
    }
    
    static func community(instanceName: String, type: TimelineType = .public, range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        
        if let currentAccount = AccountsManager.shared.currentAccount as? MastodonAcctData {
            let client = Client(
                baseURL: "https://\(instanceName)",
                accessToken: currentAccount.instanceData.accessToken
            )
            
            switch type {
            case .public:
                let request = Timelines.public(local: true, range: range)
                let result = try await ClientService.runRequest(client: client, request: request)
                return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
            case .trending:
                let request = Statuses.trendingStatuses(range: range)
                let result = try await ClientService.runRequest(client: client, request: request)
                return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
            }
        }
 
        return ([], cursorId: nil)
    }
    
    static func tag(hashtag: String, range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Timelines.tag(hashtag, local: false, range: range)
        let result = try await ClientService.runRequest(request: request)
        return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
    }
    
    static func list(listId: String, range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Timelines.lists(listId: listId, range: range)
        let result = try await ClientService.runRequest(request: request)
        return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
    }
    
    static func channel(channelId: String, range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Timelines.channel(channelId: channelId, range: range)
        let result = try await ClientService.runMothRequest(request: request)
        return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
    }
    
    static func federated(range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Timelines.public(local: false, range: range)
        let result = try await ClientService.runRequest(request: request)
        return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
    }
    
    /// Fetches Statuses from Moth.social's For You Timeline
    /// Requires full original account
    static func forYou(remoteFullOriginalAcct: String, range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Timelines.forYouV4(remoteFullOriginalAcct: remoteFullOriginalAcct, range: range)
        let result = try await ClientService.runMothRequest(request: request)
        return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
    }
    
    /// Fetches Statuses from Mammoth Picks' For You Timeline
    /// DOES NOT require auth
    static func forYouMammothPicks(range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Timelines.forYouMammothPicks(range: range)
        let client = Client(baseURL: Configuration.ForYouEndpoint)
        let result = try await ClientService.runRequest(client: client, request: request)
        return (result.filter({ $0.visibility != .direct }), cursorId: result.last?.id)
    }
    
    /// Fetches For You Feed Type
    static func forYouMe(remoteFullOriginalAcct: String) async throws -> ForYouAccount {
        let request = Timelines.forYouMe(remoteFullOriginalAcct: remoteFullOriginalAcct)
        let result = try await ClientService.runMothRequest(request: request)
        return result
    }

    /// Fetches info for a post in the For You feed
    static func forYouStatusSource(id: String) async -> [StatusSource]? {
        let request = Timelines.forYouStatusSource(id: id)
        let result = try? await ClientService.runMothRequest(request: request)
        return result
    }

    /// Sets For You Feed Type
    static func updateForYouMe(remoteFullOriginalAcct: String, forYouInfo: ForYouType) async throws -> ForYouAccount {
        let request = Timelines.updateForYouMe(remoteFullOriginalAcct: remoteFullOriginalAcct, forYouInfo: forYouInfo)
        let result = try await ClientService.runMothRequest(request: request)
        return result
    }
    
    static func likes(range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Favourites.all(range: range)
        let result = try await ClientService.runRequest(request: request)
        return (result, cursorId: result.last?.id)
    }

    static func bookmarks(range: RequestRange = .default) async throws -> ([Status], cursorId: String?) {
        let request = Bookmarks.bookmarks(range: range)
        let result = try await ClientService.runRequest(request: request)
        return (result, cursorId: result.last?.id)
    }
    
    static func mentions(range: RequestRange = .default) async throws -> ([Notificationt], cursorId: String?) {
        let request = Notifications.all(range: range, typesToExclude: [.favourite, .reblog, .follow, .follow_request, .poll, .update, .status])
        let result = try await ClientService.runRequest(request: request)
        return (result, cursorId: result.last?.id)
    }
    
    static func activity(range: RequestRange = .default, type: NotificationType?) async throws -> ([Notificationt], cursorId: String?) {
        let excludedTypes: [NotificationType] = NotificationType.allCases.filter({
            switch type {
            case .favourite:
                return $0 != .favourite
            case .reblog:
                return $0 != .reblog
            case .follow:
                return $0 != .follow
            case .update:
                return $0 != .status
            default:
                return [NotificationType.direct, NotificationType.mention].contains($0)
            }
        })
        let request = Notifications.all(range: range, typesToExclude: excludedTypes)
        let result = try await ClientService.runRequest(request: request)
        return (result, cursorId: result.last?.id)
    }
}
