//
//  BlogPostService.swift
//  
//
//  Created by Daniel Mandea on 28/09/2019.
//

import Foundation
import MTDBlogComponents
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class DefaultBlogPostService: BaseService<DefaultServiceConfiguration>, Requests, RequestComposer {
    
    // MARK: - Internal
    
    public var imageService: ImageService!
}

// MARK: - BlogPostService

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension DefaultBlogPostService: BlogPostService  {
    
    public func create(blogPost: BlogPost) -> AnyPublisher<BlogPost, Error> {
        let urlRequest = decodableRquest(with: .post, path: Constants.Api.Blog.Routs.post, object: blogPost, headers: Constants.Api.Blog.headers)
        let publisher: AnyPublisher<BlogPost, Error> = fetch(with: urlRequest)
        return publisher.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
    
    public func upload(blogPost: BlogPost, with thumbnail: Data) -> AnyPublisher<BlogPost, Error> {
        return imageService.upload(image: thumbnail).flatMap { imageURL -> AnyPublisher<BlogPost, Error> in
            blogPost.thumbnailImageUrl = imageURL
            return self.create(blogPost: blogPost)
        }
       .receive(on: RunLoop.main)
       .eraseToAnyPublisher()
    }
    
    public func get(since date: Date?) -> AnyPublisher<[BlogPost], Error> {
        let publisher: AnyPublisher<[BlogPost], Error> = get(from: Constants.Api.Blog.Routs.posts)
        return publisher.receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
