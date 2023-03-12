//
//  LocationTVCell.swift
//  NearByPlaces
//
//  Created by ios department on 12/19/22.
//

import UIKit

class ListTVCell: UITableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var addressLocationLbl: UILabel!
    
    @IBOutlet weak var kmLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//
//    }

}

struct FilterType
{
    var type:Filter
}
enum Filter:String
{
    case TYPE_ALL =  "all"
    case TYPE_BS =  "Bader & Saunen"
    case TYPE_SS =  "Strande & Seen"
    case TYPE_HC =  "Hotels  & Camping"

}
