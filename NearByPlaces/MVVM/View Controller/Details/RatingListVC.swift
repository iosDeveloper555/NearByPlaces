//
//  RatingListVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 20/02/23.
//
import UIKit
import CoreLocation
import MapKit

class RatingListVC: BaseVC {
    

    @IBOutlet weak var tableDetails: UITableView!
    var locationDetail:HomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
//
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
        
    }
    


}
//MARK:  - UITableViewDelegate
extension RatingListVC:UITableViewDelegate,UITableViewDataSource
{
  
    func setUpTableView()
    {
        self.tableDetails.delegate=self
        self.tableDetails.dataSource=self
        self.tableDetails.registerTableCell(identifier: kRatingListTCell)
        self.tableDetails.estimatedRowHeight = 100
        self.tableDetails.rowHeight = UITableView.automaticDimension


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        let cell = tableView.dequeueReusableCell(withIdentifier: kRatingListTCell) as! RatingListTCell
            cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
        
    }
 
    
    
}

