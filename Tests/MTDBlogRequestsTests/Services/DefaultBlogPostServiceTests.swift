//
//  DefaultBlogPostServiceTests.swift
//  
//
//  Created by Daniel Mandea on 28/09/2019.
//

import Foundation
import XCTest
import MTDBlogComponents
@testable import MTDBlogRequests

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class DefaultBlogPostServiceTests: XCTestCase {
    
    // MARK: - Test variables
    
    var imageData: Data!
    var sut: BlogPostService!
    var imageService: ImageService!
    var oauthService: OAuthService!
    var blogPost: BlogPost!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        imageData = ImageMock(base64: base64Image).decode()
        oauthService = DefaultOAuthService(configuration: DefaultServiceConfiguration(baseUrl: Constants.Api.OAuth.url))
        imageService = DefaultImageService(oauth: oauthService, configuration: DefaultServiceConfiguration(baseUrl: Constants.Api.Image.url))
        let blogPostService = DefaultBlogPostService(configuration: DefaultServiceConfiguration(baseUrl: Constants.Api.Blog.url))
        blogPostService.imageService = imageService
        sut = blogPostService
        blogPost = BlogPost.mock()
    }
    
    override func tearDown() {
        imageData = nil
        sut = nil
        imageService = nil
        oauthService = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testUploadBlogPostWIthImage() {
        // Image Data
        let exp = expectation(description: "blog-post-create-with-image")
        _ = sut.upload(blogPost: blogPost, with: imageData).sink(receiveCompletion: { (completion) in
            exp.fulfill()
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }, receiveValue: { blogPost in
            XCTAssertNotNil(blogPost)
        })
        wait(for: [exp], timeout: 10)
    }
    
    func testUploadBlogPost() {
        // Image Data
        let exp = expectation(description: "blog-post-create")
        _ = sut.create(blogPost: blogPost).sink(receiveCompletion: { (completion) in
            exp.fulfill()
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }, receiveValue: { blogPost in
            XCTAssertNotNil(blogPost)
        })
        wait(for: [exp], timeout: 10)
    }
    
    func testGetAll() {
        // Image Data
        let exp = expectation(description: "blog-post-create")
        _ = sut.get(since: nil).sink(receiveCompletion: { (completion) in
            exp.fulfill()
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }, receiveValue: { blogPosts in
            XCTAssertNotNil(blogPosts)
        })
        wait(for: [exp], timeout: 10)
    }
}
