//
//  TopStarTVCell.swift
//  NearByPlaces
//
//  Created by ios department on 12/19/22.
//

import UIKit

class TopStarTVCell: UITableViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var titleLblOutlet: UILabel!
    
    @IBOutlet weak var imgOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        imgOutlet.layer.cornerRadius = 15
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
