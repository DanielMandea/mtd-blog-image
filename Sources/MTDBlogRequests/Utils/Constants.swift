//
//  Constants.swift
//  
//
//  Created by Daniel Mandea on 16/09/2019.
//

import Foundation

public struct Constants {
    public struct Api {
        struct Image {
            static let url: URL = URL(string:"https://s3.eu-de.cloud-object-storage.appdomain.cloud/foto-app/")!
            static let invalidUrl = "invalid-url"
        }
        public struct OAuth {
            public static let url: URL = URL(string: "https://iam.bluemix.net/oidc/token?apikey=0TyIDxgDWBNQqjEChFvjV3fGPpg5HXZ8bFj_14B6Tq3E&response_type=cloud_iam&grant_type=urn:ibm:params:oauth:grant-type:apikey")!
        }
    }
}
