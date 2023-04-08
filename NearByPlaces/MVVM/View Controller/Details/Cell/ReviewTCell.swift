//
//  ReviewTCell.swift
//  NearByPlaces
//
//  Created by Amarendra on 08/04/23.
//

import UIKit
import FloatRatingView

class ReviewTCell: UITableViewCell {

    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var txtReview: UITextField!
    @IBOutlet weak var lblReviewCount: UILabel!
    @IBOutlet weak var viewrating: FloatRatingView!
    @IBOutlet weak var lblRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
