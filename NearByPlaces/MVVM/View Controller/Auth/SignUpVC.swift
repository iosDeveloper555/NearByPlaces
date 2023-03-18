//
//  SignUpVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import UIKit

class SignUpVC: BaseVC {
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupAct(_ sender: UIButton)
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
    
    @IBAction func loginAct(_ sender: Any)
    {
        
        let vc = SignInVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Private Functions
    private func validateData () -> String?
    {
        
        if txtName.text?.count == 0
        {
            return  kEmptyFirstNameAlert
        }
        if (txtName.text?.count ?? 0) < 2
        {
            return  kMinNameAlert
        }
        
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

extension SignUpVC
{
    func CallAPI()
    {
        if Connectivity.isConnectedToInternet {
            var data = JSONDictionary()
            
            data[ApiKey.kName] = self.txtName.text!
            data[ApiKey.kEmail] = self.txtEmail.text!
            data[ApiKey.kPassword] = self.txtPassword.text!
            
            self.callSignUpAPI(data: data)
        } else {
            
            self.openSimpleAlert(message: APIManager.INTERNET_ERROR)
        }
    }
    func callSignUpAPI(data:JSONDictionary)
    {
        AuthVM.shared.callApiForSignUp(data: data, response: { (message, error) in
            
            if error != nil
            {
                self.showErrorMessage(error: error)
            }
            else{
                
                debugPrint("signup success! id is \(AuthVM.shared.userData)")
                if let code = AuthVM.shared.userData?.status as? String, code == kSuccess
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
