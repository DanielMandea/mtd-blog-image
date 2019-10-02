//
//  BaseService.swift
//  
//
//  Created by Daniel Mandea on 20/09/2019.
//

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, *)
public class BaseService<T: ServiceConfiguration> {
    
    // MARK: - Variables
    
    public var session: URLSession
    public var configuration: T    
    
    // MARK: - Init 
    
    public init(session: URLSession = URLSession.shared, configuration: T) {
        self.session = session
        self.configuration = configuration
    }
    
    // MARK: - Helpers
    
    static func validate(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw RequestError.statusCode(httpResponse.statusCode)
        }
        return data
    }
}

// MARK: - TaskPublisher

@available(OSX 10.15, iOS 13.0, *)
extension BaseService: TaskPublisher {
    func taskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        return session.dataTaskPublisher(for: request)
    }
}
