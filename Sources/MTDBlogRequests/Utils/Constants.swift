//
//  Constants.swift
//  
//
//  Created by Daniel Mandea on 16/09/2019.
//

import Foundation

public struct Constants {
    public struct Api {
        public struct Image {
            public static let url: URL = URL(string:"https://s3.eu-de.cloud-object-storage.appdomain.cloud/foto-app/")!
            public static let invalidUrl = "invalid-url"
            public static let headers = ["Content-Type":"image/jpeg"]
        }
        public struct OAuth {
            public static let url: URL = URL(string: "https://iam.bluemix.net/oidc/token?apikey=0TyIDxgDWBNQqjEChFvjV3fGPpg5HXZ8bFj_14B6Tq3E&response_type=cloud_iam&grant_type=urn:ibm:params:oauth:grant-type:apikey")!
            static let headers = ["Content-Type":"application/x-www-form-urlencoded", "Accept":"application/json"]
        }
        public struct Blog {
            public static let url: URL = URL(string: "http://localhost:8080")!
            static let headers = ["Content-Type":"application/json"]
            struct Routs {
                static let posts: String = "posts"
                static let post: String = "post"
            }
        }
    }
}
