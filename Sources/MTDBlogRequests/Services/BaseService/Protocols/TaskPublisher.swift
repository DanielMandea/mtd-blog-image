//
//  TaskPublisher.swift
//  
//
//  Created by Daniel Mandea on 20/09/2019.
//

import Foundation

@available(OSX 10.15, iOS 13.0, *)
protocol TaskPublisher {
    func taskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}
