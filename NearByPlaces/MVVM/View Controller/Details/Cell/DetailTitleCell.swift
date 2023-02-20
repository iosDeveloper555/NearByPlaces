//
//  DetailTitleCell.swift
//  NearByPlaces
//
//  Created by Amarendra on 18/02/23.
//

import UIKit

class DetailTitleCell: UITableViewCell {

        @IBOutlet weak var lblName: UILabel!
        @IBOutlet weak var navigationInView: UIView!
       @IBOutlet weak var lblAddress: UILabel!
        @IBOutlet weak var ratingInView: UIView!
    
    @IBOutlet weak var btnNavigation: UIButton!
    @IBOutlet weak var btnRating: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
