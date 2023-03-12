//
//  UserModel.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import Foundation


struct UserModel
{
    var name:String?
    var id:Int?
    var email:String?

    var password:String?
    var created_at:String?
    var updated_at:String?
    
    init(data:JSONDictionary)
    {
        self.name =  data[ApiKey.kName] as? String
        self.email =  data[ApiKey.kEmail] as? String

        self.id =  data[ApiKey.kId] as? Int
        self.password =  data[ApiKey.kPassword] as? String

    }

}
