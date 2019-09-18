//
//  ImageService.swift
//  
//
//  Created by Daniel Mandea on 16/09/2019.
//

import Foundation
import Combine

public struct ImageService {

    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func upload(at url:URL, image: Data, oAuth: OAuth) -> AnyPublisher<String, Error> {
        let finalUrl = url.appendingPathComponent("\(NSUUID().uuidString).jpg")
        var urlRequest = URLRequest(url: finalUrl)
        urlRequest.httpMethod = "PUT"
        urlRequest.httpBody = image
        urlRequest.allHTTPHeaderFields = ["Content-Type":"image/jpeg", "Authorization":"Bearer \(oAuth.accessToken)"]
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError {$0 as Error}
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {return Constants.Api.Image.invalidUrl}
                return finalUrl.absoluteString
            }
            .eraseToAnyPublisher()
    }
    
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public static func upload(at url: URL, image: Data) -> AnyPublisher<String, Error> {
       return OAuthService.tokenPublisher()
        .flatMap { oAuth in return ImageService.upload(at: url, image: image, oAuth: oAuth) }
        .eraseToAnyPublisher()
    }
}
