//
//  File.swift
//  
//
//  Created by Daniel Mandea on 17/09/2019.
//

import Foundation

extension Dictionary where Key == String, Value == String {

    mutating func append(_ data:[String:String]) {
        for (key, value) in data {
            self.updateValue(value, forKey: key)
        }
    }
}
