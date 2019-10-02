//
//  File.swift
//  
//
//  Created by Daniel Mandea on 17/09/2019.
//

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class DefaultOAuthService: BaseService<DefaultServiceConfiguration>, Requests, RequestComposer {
    
}

// MARK: - OAuthService

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension DefaultOAuthService: OAuthService {
    public func token() -> AnyPublisher<OAuth, Error> {
        let oAuthPublisher: AnyPublisher<OAuth, Error> = fetch(with: .post)
        return oAuthPublisher
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
