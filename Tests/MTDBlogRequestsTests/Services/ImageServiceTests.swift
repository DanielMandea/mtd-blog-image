//
//  ImageServiceTests.swift
//  
//
//  Created by Daniel Mandea on 17/09/2019.
//

import Foundation
import XCTest
@testable import MTDBlogRequests

class ImageServiceTests: XCTestCase {
    
    // MARK: - Test variables
    
    var imageData: Data!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        imageData = ImageMock(base64: base64Image).decode()
    }
    
    override func tearDown() {
        imageData = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testUploadImage() {
        // Image Data
        let exp = expectation(description: "upload-image-token")
        _ = ImageService.upload(at: Constants.Api.Image.url, image: imageData).sink(receiveCompletion: { completion in
            exp.fulfill()
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }, receiveValue: { imageUrl in
            XCTAssertNotNil(imageUrl)
        })
        wait(for: [exp], timeout: 10)
    }
}
