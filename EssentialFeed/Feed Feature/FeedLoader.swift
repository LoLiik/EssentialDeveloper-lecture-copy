//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Евгений Кулиничев on 12.10.2020.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
