//
//  ForumVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 08/04/23.
//

import UIKit
class ForumVC: BaseVC {
    

    @IBOutlet weak var lblTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backBtnTapped(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
        
    }
    


}
