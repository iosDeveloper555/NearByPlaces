//
//  RatingListTCell.swift
//  NearByPlaces
//
//  Created by Amarendra on 20/02/23.
//

import UIKit
import FloatRatingView

class RatingListTCell: UITableViewCell {
    @IBOutlet weak var lblAccountLink: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var viewrating: FloatRatingView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
