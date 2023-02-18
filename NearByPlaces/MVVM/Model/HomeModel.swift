//
//  HomeModel.swift
//  NearByPlaces
//
//  Created by Amarendra on 17/02/23.
//

import Foundation

struct HomeModel
{
    var id:Int?
    var country:String?
    var state:String?
    var address:String?
    var name:String?
    
    var description:String?
    var filter:String?
    var latitude:String?
    var longitude:String?
    var location_image:String?
    var top_ten:String?
    
    init(dict:JSONDictionary) {
        self.id = dict[ApiKey.kId] as? Int
        self.country = dict[ApiKey.kCountry] as? String
        self.state = dict[ApiKey.kCountry] as? String
        self.address = dict[ApiKey.kAddress] as? String
        self.name = dict[ApiKey.kName] as? String
        
        self.description = dict[ApiKey.kDescription] as? String
        self.filter = dict[ApiKey.kFilter] as? String
        self.latitude = dict[ApiKey.kLatitude] as? String
        self.longitude = dict[ApiKey.kLatitude] as? String
        self.location_image = dict[ApiKey.kLocation_image] as? String
        self.top_ten = dict[ApiKey.kTop_ten] as? String
    }

}
//{
//           "id": 235,
//           "country": "italy",
//           "state": "Campania",
//           "address": "Traversa Punta Capo, 80067 Sorrento N",
//           "name": "Bagni Regina Giovanna",
//           "description": "Es ist ein sehr schöner Strand zum Baden. Es ist ein Geheimtip und unter der Woche sind sehr wenige Leute da.",
//           "filter": "Hotels  & Camping",
//           "latitude": "44.1114",
//           "longitude": "11.2846",
//           "location image": "",
//           "top_ten": ""
//       }
