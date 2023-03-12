//
//  DataManager.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import Foundation

class DataManager
{
    static var userId:Int?
    {
        get
        {
            UserDefaults.standard.value(forKey: "userId") as? Int ?? 0
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: "userId")
            UserDefaults.standard.synchronize()
        }
    }
}
