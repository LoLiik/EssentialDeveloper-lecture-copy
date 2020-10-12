//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Евгений Кулиничев on 12.10.2020.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}


protocol FeedLoader {
    
    func load(completion: @escaping (LoadFeedResult) -> Void)
    
}
