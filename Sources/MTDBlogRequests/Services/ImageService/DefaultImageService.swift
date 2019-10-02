//
//  ImageService.swift
//  
//
//  Created by Daniel Mandea on 16/09/2019.
//

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class DefaultImageService: BaseService<DefaultServiceConfiguration>, Requests, RequestComposer {
    
    // MARK: - Public Variables
    
    public var oauth: OAuthService
    
    // MARK: - Init
    
    public init(oauth: OAuthService, configuration: DefaultServiceConfiguration) {
        self.oauth = oauth
        super.init(configuration: configuration)
    }
    
    // MARK: - Helpers 
    
    func buildUploadRequest(for image: Data, oAuth: OAuth) -> URLRequest {
        var headers = Constants.Api.Image.headers 
        headers["Authorization"] = "Bearer \(oAuth.accessToken)"
        return dataRquest(with: .put, path: "\(NSUUID().uuidString).jpg", object: image, headers: headers)
    }
    
    static func validateImageUrl(_ request: URLRequest, _ data: Data, _ response: URLResponse) throws -> String {
        guard let httpResponse = response as? HTTPURLResponse else { throw RequestError.invalidResponse }
        guard (200..<300).contains(httpResponse.statusCode) else { throw RequestError.statusCode(httpResponse.statusCode) }
        return request.url?.absoluteString ?? "Invalid URL"
    }
    
    // MARK: - Publihers
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func imagePublisher(image: Data, oAuth: OAuth) -> AnyPublisher<String, Error> {
        let request = buildUploadRequest(for: image, oAuth: oAuth)
        return taskPublisher(for: request)
            .mapError { $0 as Error }
            .tryMap { output in
                return try DefaultImageService.validateImageUrl( request, output.data, output.response)
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

// MARK: - ImageService

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension DefaultImageService: ImageService {
    
    public func upload(image: Data) -> AnyPublisher<String, Error> {
        return oauth.token()
            .flatMap { oAuth in
                return self.imagePublisher(image: image, oAuth: oAuth)
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
