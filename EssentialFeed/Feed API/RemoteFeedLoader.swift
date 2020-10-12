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

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { clientResponse in
            switch clientResponse {
            case .success(_, _):
                completion(.invalidData)
            case .failure(_):
                completion(.connectivity)
            }
        }
    }

}



