//
//  OAuthServiceTests.swift
//  
//
//  Created by Daniel Mandea on 17/09/2019.
//

import Foundation
import XCTest
@testable import MTDBlogRequests

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class OAuthServiceTests: XCTestCase {
    
    // MARK: - Test Variables
    
    var sut: DefaultOAuthService!
    var configuration: DefaultServiceConfiguration!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        configuration = DefaultServiceConfiguration(baseUrl: Constants.Api.OAuth.url)
        sut = DefaultOAuthService(configuration: configuration)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testFetchToken() {
        let exp = expectation(description: "cos-token")
        _ = sut.token()
            .sink(receiveCompletion: { (completion) in
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

