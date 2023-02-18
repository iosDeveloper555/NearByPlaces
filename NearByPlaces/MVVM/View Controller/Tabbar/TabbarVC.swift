//
//  TabbarVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 04/01/23.
//

import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBarItems()
        // Do any additional setup after loading the view.
    }
    func setTabBarItems(){
          
          let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
          myTabBarItem1.image = UIImage(named: "HomeUnselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
          myTabBarItem1.selectedImage = UIImage(named: "Homeselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
          myTabBarItem1.title = ""
          myTabBarItem1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
          
          let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
          myTabBarItem2.image = UIImage(named: "listUnselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem2.selectedImage = UIImage(named: "Listselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem2.title = ""
          myTabBarItem2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
          
          
          let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
          myTabBarItem3.image = UIImage(named: "topUnSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem3.selectedImage = UIImage(named: "TopSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem3.title = ""
          myTabBarItem3.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
          
          let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
          myTabBarItem4.image = UIImage(named: "LoactionUnselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem4.selectedImage = UIImage(named: "Locationselected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
          myTabBarItem4.title = ""
          myTabBarItem4.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let myTabBarItem5 = (self.tabBar.items?[4])! as UITabBarItem
        myTabBarItem5.image = UIImage(named: "SettingUnSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem5.selectedImage = UIImage(named: "SettingSelected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem5.title = ""
        myTabBarItem5.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
          
     }

}
