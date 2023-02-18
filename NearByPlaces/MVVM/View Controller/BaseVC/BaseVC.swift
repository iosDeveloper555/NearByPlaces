//
//  BaseVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 05/01/23.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setHeader()
    {
        
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.red
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.red
        }
        
//    UIApplication.shared.statusBarStyle = .lightContent
//    UIApplication.shared.isStatusBarHidden = false
//    self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.barStyle = .default
//    self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.white//.AppColor.navBarColor.color()
//    self.navigationController?.navigationBar.isTranslucent = false
//self.navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .any, barMetrics: .default)
//    self.navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
//
//
    
        /*
    let titleButton = UIButton(frame: CGRect(x: 50, y:0, width:110, height:30))
    titleButton.titleLabel?.textAlignment = .center
    titleButton.setTitle(title, for: .normal)
    titleButton.isUserInteractionEnabled = false
    titleButton.titleEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 7, right: 0)
    titleButton.setTitleColor(UIColor.black, for: .normal)
    titleButton.titleLabel?.font = UIFont.CustomFont.regular.fontWithSize(size: 28.0)
    
    self.navigationItem.titleView = titleButton
    
    //Hide back button
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)


        
        if showBack {
            self.setBackButton()
        }
        else {
            self.navigationItem.hidesBackButton = true
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        if showMenuButton {
            self.setMenuButton()
        }
        
        */
        
    }
    func getStatusBarHeight() -> CGFloat {
       var statusBarHeight: CGFloat = 0
       if #available(iOS 13.0, *) {
           let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
           statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
       } else {
           statusBarHeight = UIApplication.shared.statusBarFrame.height
       }
       return statusBarHeight
   }

    func openSettings(message:String)
    {
        
        let alertController = UIAlertController (title: "Alert", message: message, preferredStyle: .alert)

           let settingsAction = UIAlertAction(title: "Ok", style: .default) { (_) -> Void in

               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }

               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                       print("Settings opened: \(success)") // Prints true
                   })
               }
           }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
           alertController.addAction(settingsAction)
           

        self.present(alertController, animated: true, completion: nil)
    }
    func showErrorMessage(error: Error?) {
        /*
         STATUS CODES:
         200: Success (If request sucessfully done and data is also come in response)
         204: No Content (If request successfully done and no data is available for response)
         401: Unauthorized (If token got expired)
         451: Block (If User blocked by admin)/delete by admin
         403: Delete (If User deleted by admin)
         406: Not Acceptable (If user is registered with the application but not verified)
         */
        let message = (error! as NSError).userInfo[ApiKey.kMessage] as? String ?? kSomethingWentWrong
        self.openSimpleAlert(message: message)
    }
    
    func openSimpleAlert(title:String="Alert!",message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
}
extension UIColor {
    //TO REMOVE THE NAVIGATION BAR LINE
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
