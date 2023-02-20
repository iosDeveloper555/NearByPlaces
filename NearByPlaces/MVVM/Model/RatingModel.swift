//
//  RatingModel.swift
//  NearByPlaces
//
//  Created by Amarendra on 20/02/23.
//

import Foundation
struct RatingModel
{
    var rating:Int?
    var author_name:String?
    var author_url:String?
    var profile_photo_url:String?
    var relative_time_description:String?
    
    var text:String?
    var time:Int?
    
    init(dict:JSONDictionary) {
        self.rating = dict["rating"] as? Int
        self.author_name = dict["author_name"] as? String
        self.author_url = dict["author_url"] as? String
        self.profile_photo_url = dict["profile_photo_url"] as? String
        self.relative_time_description = dict["relative_time_description"] as? String
        
        self.text = dict["text"] as? String
        self.time = dict["time"] as? Int
     
    }

}
