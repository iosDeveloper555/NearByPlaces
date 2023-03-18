//
//  SignInVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import UIKit

class SignInVC: BaseVC {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupAct(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginAct(_ sender: Any)
    {
       
        if let message = validateData()
        {
            self.openSimpleAlert(message: message)
        }
        else
        {
            self.CallAPI()
        }
        
    }
    // MARK: - Private Functions
    private func validateData () -> String?
    {

       
        if txtEmail.text?.count == 0
        {
            return  kEmptyEmailAlert
        }
        if (!(txtEmail.text?.isValidEmail() ?? false))
        {
            return kValidEmailAlert
        }
        if txtPassword.text?.count == 0
        {
            return  kEmptyPasswordAlert
        }
       
        if (txtPassword.text?.count ?? 0) < 6
        {
            return  kMinPasswordAlert
        }
        
        return nil
     }
}
// MARK: - Api Calls

extension SignInVC
{
    func CallAPI()
    {
        if Connectivity.isConnectedToInternet {
            var data = JSONDictionary()
            
            data[ApiKey.kEmail] = self.txtEmail.text!
            data[ApiKey.kPassword] = self.txtPassword.text!
            
            self.callSignInAPI(data: data)
        } else {
            
            self.openSimpleAlert(message: APIManager.INTERNET_ERROR)
        }
    }
    func callSignInAPI(data:JSONDictionary)
    {
        AuthVM.shared.callApiForSignIn(data: data, response: { (message, error) in
            
            if error != nil
            {
                self.showErrorMessage(error: error)
            }
            else{
                
                debugPrint("signup success! id is \(AuthVM.shared.userData)")
                if let code  = AuthVM.shared.userData?.status as? Int, code == 200
                {
                    SCENEDEL?.navigateToHome()

                }
                else
                {
                    self.openSimpleAlert(message: AuthVM.shared.userData?.message ?? kEmptyString)
                }
            }
        })
    }
}
