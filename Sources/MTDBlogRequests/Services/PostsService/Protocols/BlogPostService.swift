//
//  BlogPostService.swift
//  
//
//  Created by Daniel Mandea on 22/09/2019.
//

import Foundation
import MTDBlogComponents
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol BlogPostService {
    func upload(blogPost: BlogPost, with thumbnail: Data) -> AnyPublisher<BlogPost, Error>
    func create(blogPost: BlogPost) -> AnyPublisher<BlogPost, Error>
    func get(since date: Date?) -> AnyPublisher<[BlogPost], Error>
}
