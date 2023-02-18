//
//  LocationDetailVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/19/22.
//

import UIKit

class LocationDetailVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var navigationInView: UIView!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var ratingInView: UIView!
    
    @IBOutlet weak var describeLbl: UILabel!
    var locationDetail:HomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.describeLbl.text = locationDetail?.description
        self.lblName.text = locationDetail?.name

        self.lblAddress.text = locationDetail?.address
        self.imgView.setImageFromRemoteUrl(url: locationDetail?.location_image ?? "")
       
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
        
    }
    


}
