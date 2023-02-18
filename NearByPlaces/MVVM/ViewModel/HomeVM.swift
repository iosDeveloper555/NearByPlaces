//
//  HomeVM.swift
//  NearByPlaces
//
//  Created by Amarendra on 17/02/23.
//

import Foundation
class HomeVM {
    
    static var shared = HomeVM()
    var homeUserList:[HomeModel] = []
    
    private init(){}
    func callApiForHomeData(data: JSONDictionary,response: @escaping responseCallBack)
    {
        APIManager.callApiForHomeData(data:data,successCallback: { (responseDict) in
            
            let message = responseDict[ApiKey.kMessage] as? String ?? kSomethingWentWrong
            self.homeUserList.removeAll()
            self.parseHomeData(response:responseDict)

            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func callApiGetUnit(response: @escaping responseCallBack)
    {
//        APIManager.callApiGetUnit(successCallback: { (responseDict) in
//
//            let message = responseDict[ApiKey.kMessage] as? String ?? kSomethingWentWrong
//            self.unitData.removeAll()
//            self.parseGetUnitData(response:responseDict)
//            response(message, nil)
//        }) { (errorReason, error) in
//            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
//        }
    }
}
extension APIManager {
    
    //MARK: - callApiForHomeData
    
    class func callApiForHomeData(data: JSONDictionary,successCallback: @escaping JSONDictionaryResponseCallback,failureCallback: @escaping APIServiceFailureCallback){
        APIServicesHome.getHomeData(data: data).request(isJsonRequest: true,success:{ (response) in
            if let responseDict = response as? JSONDictionary {
                print(responseDict)
                
                successCallback(responseDict)
            } else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    
    //MARK:- call Api get unit
    
//    class func callApiGetUnit(successCallback: @escaping JSONDictionaryResponseCallback,failureCallback: @escaping APIServiceFailureCallback){
//        APIServicesAccount.getUnit.request(success: { (response) in
//            if let responseDict = response as? JSONDictionary {
//                print(responseDict)
//
//                successCallback(responseDict)
//            } else {
//                successCallback([:])
//            }
//        }, failure: failureCallback)
//
//    }
}

extension HomeVM
{
  
    func parseHomeData(response: JSONDictionary){
        if let data = response[ApiKey.kData] as? JSONArray
        {
            
            for dict in data
            {
                let user = HomeModel(dict: dict)
                self.homeUserList.append(user)

            }
  
        }
    }
          

}
