//
//  File.swift
//  
//
//  Created by Daniel Mandea on 17/09/2019.
//

import Foundation
import Combine

public struct OAuthService {
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func tokenPublisher(from url: URL = Constants.Api.OAuth.url) -> AnyPublisher<OAuth, Error> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = ["Content-Type":"application/x-www-form-urlencoded", "Accept":"application/json"]
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { $0 as Error}
            .map {$0.data}
            .decode(type: OAuth.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}
