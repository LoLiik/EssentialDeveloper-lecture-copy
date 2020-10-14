//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Евгений Кулиничев on 12.10.2020.
//

import Foundation


public final class RemoteFeedLoader: FeedLoader {

    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadFeedResult

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] clientResponse in
            guard self != nil else { return }
            switch clientResponse {
            case .success(let data, let response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure(_):
                completion(.failure(Error.connectivity))
            }
        }
    }

}
