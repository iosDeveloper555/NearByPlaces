//
//  AuthVM.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import Foundation

class AuthVM
{
    
    static var shared = AuthVM()
    var userData:ResponseModel?
    
    private init(){}
    func callApiForSignUp(data: JSONDictionary,response: @escaping responseCallBack)
    {
        APIManager.callApiForSignUp(data:data,successCallback: { (responseDict) in
            
            let message = responseDict[ApiKey.kMessage] as? String ?? kSomethingWentWrong
            self.parseSignInData(response:responseDict)
            
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func callApiForSignIn(data: JSONDictionary,response: @escaping responseCallBack)
    {
        APIManager.callApiForSignIn(data:data,successCallback: { (responseDict) in
            
            let message = responseDict[ApiKey.kMessage] as? String ?? kSomethingWentWrong
            self.parseSignInData(response:responseDict)
            
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }

    
}
extension APIManager {
    
    //MARK: - callApiForSignIn
    
    class func callApiForSignIn(data: JSONDictionary,successCallback: @escaping JSONDictionaryResponseCallback,failureCallback: @escaping APIServiceFailureCallback){
        APIServicesAuth.SignInUser(data: data).request(isJsonRequest: true,success:{ (response) in
            if let responseDict = response as? JSONDictionary {
                print(responseDict)
                
                successCallback(responseDict)
            } else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func callApiForSignUp(data: JSONDictionary,successCallback: @escaping JSONDictionaryResponseCallback,failureCallback: @escaping APIServiceFailureCallback){
        APIServicesAuth.SignUpUser(data: data).request(isJsonRequest: true,success:{ (response) in
            if let responseDict = response as? JSONDictionary {
                print(responseDict)
                
                successCallback(responseDict)
            } else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
}

extension AuthVM
{
  
    func parseSignInData(response: JSONDictionary){
        //if let data = response[ApiKey.kResponse] as? JSONDictionary
       // {
        
            self.userData = ResponseModel(data: response)
            
        DataManager.userId = self.userData?.response?.id ?? 0
        //}
    }
          

}
