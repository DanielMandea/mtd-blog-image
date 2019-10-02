//
//  ImageServiceTests.swift
//  
//
//  Created by Daniel Mandea on 17/09/2019.
//

import Foundation
import XCTest
@testable import MTDBlogRequests

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class ImageServiceTests: XCTestCase {
    
    // MARK: - Test variables
    
    var imageData: Data!
    var sut: ImageService!
    var oauthService: OAuthService!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        imageData = ImageMock(base64: base64Image).decode()
        oauthService = DefaultOAuthService(configuration: DefaultServiceConfiguration(baseUrl: Constants.Api.OAuth.url))
        sut = DefaultImageService(oauth: oauthService, configuration: DefaultServiceConfiguration(baseUrl: Constants.Api.Image.url))
    }
    
    override func tearDown() {
        imageData = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testUploadImage() {
        // Image Data
        let exp = expectation(description: "cos-token-image-upload")
        _ = sut.upload(image: imageData).sink(receiveCompletion: { (completion) in
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
