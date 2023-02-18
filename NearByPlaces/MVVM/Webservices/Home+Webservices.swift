//
//  Home+Webservices.swift
//  NearByPlaces
//
//  Created by Amarendra on 17/02/23.
//

import Foundation
enum APIServicesHome:APIService {
    
    case getHomeData(data: JSONDictionary)
  //  case getUnit

    
    var path: String {
        var path = ""
        switch self {
       
        case .getHomeData:
            path = BASE_URL.appending("get-data")
            }
        return path
     }
    
    var resource: Resource {
        var resource:Resource!
        let headerDict = [kAccept:  kApplicationJson]
        switch self {
        case let .getHomeData(data):
            resource = Resource(method: .post, parameters: data, headers:headerDict)
        //case .getUnit:
          //  resource = Resource(method: .get, parameters: nil, headers: headerDict)
            
       
        }
        return resource
    }
}
