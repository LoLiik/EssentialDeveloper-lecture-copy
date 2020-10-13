//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Евгений Кулиничев on 12.10.2020.
//

import Foundation


public enum HTTPClientResponse {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}


public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResponse) -> Void)
}


public final class RemoteFeedLoader {

    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { clientResponse in
            switch clientResponse {
            case .success(let data, let response):
                if response.statusCode == 200, let root = try? JSONDecoder().decode(Root.self, from: data) {
                    completion(.success(root.items))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.connectivity))
            }
        }
    }

}


private struct Root: Decodable {
    var items: [FeedItem]
}



