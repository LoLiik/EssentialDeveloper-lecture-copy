//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Евгений Кулиничев on 12.10.2020.
//

import XCTest


class RemoteFeedLoader {
    
    let client: HTTPClient
    let url: URL
    
    init(url: URL = URL(string: "http://a-url.com")!, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
    
}


protocol HTTPClient {
    func get(from url: URL)
}


class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
    
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_init_requestDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        sut.load( )
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
}
