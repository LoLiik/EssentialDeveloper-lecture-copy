//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Евгений Кулиничев on 12.10.2020.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    
    var requestedURL: URL?
    
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
}
