//
//  OAuthServiceTests.swift
//  
//
//  Created by Daniel Mandea on 17/09/2019.
//

import Foundation
import XCTest
@testable import MTDBlogRequests

class OAuthServiceTests: XCTestCase {
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testFetchToken() {
        let exp = expectation(description: "cos-token")
        _ = OAuthService.tokenPublisher(from: Constants.Api.OAuth.url).sink(receiveCompletion: { completion in
            exp.fulfill()
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }, receiveValue: { oauth in
            XCTAssertNotNil(oauth)
        })
        wait(for: [exp], timeout: 10)
    }
}

