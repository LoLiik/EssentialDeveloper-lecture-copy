//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Евгений Кулиничев on 13.10.2020.
//

import Foundation


public enum HTTPClientResponse {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}


public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResponse) -> Void)
}
