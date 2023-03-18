//
//  UserModel.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import Foundation

struct ResponseModel
{
    var message:String?
    var status:Any?
    var response:UserModel?
    
    init(data:JSONDictionary)
    {
        self.message =  data[ApiKey.kMessage] as? String
        self.status =  data[ApiKey.kStatus] as? Any

        let user =  data[ApiKey.kResponse] as? JSONDictionary ?? [:]
        self.response = UserModel(data: user)
        
    }
    
}
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
