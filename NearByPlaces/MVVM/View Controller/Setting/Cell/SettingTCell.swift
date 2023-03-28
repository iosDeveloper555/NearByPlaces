//
//  SettingTCell.swift
//  NearByPlaces
//
//  Created by Amarendra on 12/01/23.
//

import UIKit

class SettingTCell: UITableViewCell {

    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var constLeft: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
struct SettingModel
{
    var type:settingType
    var icon:UIImage!
    
}
enum settingType:String
{
    case Chat = "Chat"
    case Forum = "Forum"
    
    case Profil = "Profil"

    case Profilinformationen = "Profilinformationen"
    
    case Password = "Passwort ändern"
    case Location = "Gerätestandort"
    case Berechtigungen = "Berechtigungen"

    case Community = "Community"
   case Logout = "Logout"
    case Login = "Login"

   case Rechtliches = "Rechtliches"
}
