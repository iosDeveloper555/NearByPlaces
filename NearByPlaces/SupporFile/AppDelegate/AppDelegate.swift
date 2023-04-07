//
//  AppDelegate.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
//import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
   var window: UIWindow?
    var users = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true

        //printFontName()
        
        
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(GoogleMapKey)
      //  GMSPlacesClient.provideAPIKey(GoogleMapKey)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension AppDelegate
{
    func navigateToInto()
    {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
    }
    func navigateToHome()
    {
        let storyBoard = UIStoryboard.init(name: "Tabbar", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
    }
    
    func navigateToLogin()
    {
        let vc = SignUpVC.instantiate(fromAppStoryboard: .Main)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
    }
    
    func printFontName()
    {
        for family in UIFont.familyNames {
          let sName: String = family as String
          debugPrint("family: \(sName)")

            for name in UIFont.fontNames(forFamilyName: sName) {
                debugPrint("name: \(name as String)")
          }
        }
    }
}
