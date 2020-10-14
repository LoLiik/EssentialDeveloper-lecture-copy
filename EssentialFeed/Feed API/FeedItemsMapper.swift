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
        var feed: [FeedItem] {
            return items.map{ $0.item }
        }
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

    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Root.self, from: data)
            else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        let items = root.feed
        return .success(items)
    }

}
