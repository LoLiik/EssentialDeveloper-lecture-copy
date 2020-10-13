//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Евгений Кулиничев on 13.10.2020.
//

import Foundation


internal final class FeedItemsMapper {

    private struct Root: Decodable {
        var items: [Item]
    }

    private struct Item: Decodable {
        public let id: UUID
        public let description: String?
        public let location: String?
        public let image: URL

        var item: FeedItem {
            return FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    static var OK_200: Int {
        200
    }
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        let root = try JSONDecoder().decode(Root.self, from: data)
        
        return root.items.map { $0.item }
    }
    
}
