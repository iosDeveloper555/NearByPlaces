//
//  SettingVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit

class SettingVC: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var settingArray:[SettingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupArray()
        setUpTableView()
    }
  
    
    func setupArray()
    {
        self.settingArray.append(SettingModel(type: .Community,icon: UIImage(named: "Chat")!))

        self.settingArray.append(SettingModel(type: .Chat,icon: UIImage(named: "Chat")!))
        self.settingArray.append(SettingModel(type: .Forum,icon: UIImage(named: "fourm")!))
        
        self.settingArray.append(SettingModel(type: .Profil,icon: UIImage(named: "fourm")!))

        self.settingArray.append(SettingModel(type: .Profilinformationen,icon: UIImage(named: "lucide_user")!))
        self.settingArray.append(SettingModel(type: .Password,icon: UIImage(named: "lock")!))
        self.settingArray.append(SettingModel(type: .Location,icon: UIImage(named: "loc")!))

        self.settingArray.append(SettingModel(type: .Berechtigungen,icon: UIImage(named: "key")!))
        //self.settingArray.append(SettingModel(type: .Community,icon: UIImage(named: "Community")!))
        self.settingArray.append(SettingModel(type: .Rechtliches,icon: UIImage(named: "Community")!))

        self.settingArray.append(SettingModel(type: .Logout,icon: UIImage(named: "loc")!))
    }
}

//MARK:  - UITableViewDelegate
extension SettingVC:UITableViewDelegate,UITableViewDataSource
{
  
    func setUpTableView()
    {
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.registerTableCell(identifier: kSettingTCell)
        self.tableView.registerTableCell(identifier: kLegalTCell)
        self.tableView.registerTableCell(identifier: kProfileHeadetTCell)


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.settingArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let model = self.settingArray[indexPath.row]
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        if model.type == .Rechtliches
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kLegalTCell) as! LegalTCell
            cell.selectedBackgroundView = bgColorView

            return cell
        }
        else if model.type == .Profil || model.type == .Community
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kProfileHeadetTCell) as! ProfileHeadetTCell
            cell.lbltitle.text = model.type.rawValue
            cell.selectedBackgroundView = bgColorView

            return cell
        }
        else
            
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kSettingTCell) as! SettingTCell
            cell.lblTitle.text = model.type.rawValue
            
            if model.type == .Chat || model.type == .Logout
            {
                cell.viewLine.isHidden=true
            }
            else
            {
                cell.viewLine.isHidden=false

            }
            if model.type == .Logout
            {
                cell.constLeft.constant = 16+8
                cell.imgIcon.isHidden=true
            }
            else
            {
                cell.constLeft.constant = 48+8
                cell.imgIcon.isHidden=false

            }
            cell.imgIcon.image = model.icon
            cell.selectedBackgroundView = bgColorView

            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.settingArray[indexPath.row]

        if model.type == .Logout
        {
            SCENEDEL?.navigateToInto()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = self.settingArray[indexPath.row]
        
        if model.type == .Rechtliches
        {
            return 200

        }
        else
        {
            return 70

        }
    }
    
}

