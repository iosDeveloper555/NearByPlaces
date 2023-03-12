//
//  Auth+Webservices.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import Foundation

enum APIServicesAuth:APIService {
    
    case SignInUser(data: JSONDictionary)
    case SignUpUser(data: JSONDictionary)
    case GetProfile(data: JSONDictionary)

    
    var path: String {
        var path = ""
        switch self {
        case .SignUpUser:
            path = BASE_URL.appending("sign-up")
        case .SignInUser:
            path = BASE_URL.appending("login")

        case .GetProfile:
            path = BASE_URL.appending("get-data")

        }
        return path
     }
    
    var resource: Resource {
        var resource:Resource!
        let headerDict = [kAccept:  kApplicationJson]
        switch self {
        case let .SignInUser(data):
            resource = Resource(method: .post, parameters: data, headers:headerDict)
            
        case let .SignUpUser(data):
            resource = Resource(method: .post, parameters: data, headers:headerDict)

        case let .GetProfile(data):
            resource = Resource(method: .post, parameters: data, headers:headerDict)

        }
        return resource
    }
}
