//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Евгений Кулиничев on 19.10.2020.
//

import Foundation


public class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    private struct UnexpectedValuesRepresentation: Error { }

    public func get(from url: URL, completion: @escaping (HTTPClientResponse) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let reponse = response as? HTTPURLResponse {
                completion(.success(data, reponse))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }
        task .resume()
    }

}
