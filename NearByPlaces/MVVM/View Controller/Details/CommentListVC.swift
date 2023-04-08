//
//  CommentListVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 08/04/23.
//
import UIKit

class CommentListVC: BaseVC {
    

    @IBOutlet weak var tableDetails: UITableView!
    @IBOutlet weak var lblTitle: UILabel!

    var locationDetail:HomeModel?
    
    var placeId = "ChIJ1Z6WLW77mUcRLDKrwySdu14"
    var ratingArray:[RatingModel] = []
    var placeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()

    }
    
    @IBAction func backBtnTapped(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
        
    }
    


}
//MARK:  - UITableViewDelegate
extension CommentListVC:UITableViewDelegate,UITableViewDataSource
{
  
    func setUpTableView()
    {
        self.tableDetails.delegate=self
        self.tableDetails.dataSource=self
        self.tableDetails.registerTableCell(identifier: kCommentTCell)
        self.tableDetails.estimatedRowHeight = 100
        self.tableDetails.rowHeight = UITableView.automaticDimension


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10//self.ratingArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        let cell = tableView.dequeueReusableCell(withIdentifier: kCommentTCell) as! CommentTCell
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
        
    }
 

    
}
