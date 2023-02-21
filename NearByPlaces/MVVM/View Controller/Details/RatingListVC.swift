//
//  RatingListVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 20/02/23.
//
import UIKit
import Alamofire

class RatingListVC: BaseVC {
    

    @IBOutlet weak var tableDetails: UITableView!
    @IBOutlet weak var lblTitle: UILabel!

    var locationDetail:HomeModel?
    
    var placeId = "ChIJ1Z6WLW77mUcRLDKrwySdu14"
    var ratingArray:[RatingModel] = []
    var placeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()

            if Connectivity.isConnectedToInternet {
        
                self.getPlaceIdAPI()
            } else {
                
                self.openSimpleAlert(message: APIManager.INTERNET_ERROR)
            }
        self.lblTitle.text = locationDetail?.name

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
        return self.ratingArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        let cell = tableView.dequeueReusableCell(withIdentifier: kRatingListTCell) as! RatingListTCell
        let model = self.ratingArray[indexPath.row]
        
        cell.lblName.text = model.author_name
        cell.lblTime.text = model.relative_time_description
        cell.lblAccountLink.text=model.author_url
        cell.txtDesc.text = model.text

        let rating = Double(model.rating ?? 0)
        cell.lblReview.text = "\(rating)"
        cell.viewrating.rating = rating
        
        cell.imgProfile.setImageFromRemoteUrl(type: .Google,url: model.profile_photo_url ?? kEmptyString)
        cell.selectedBackgroundView = bgColorView
        cell.btnAccLink.tag = indexPath.row
        cell.btnAccLink.addTarget(self, action: #selector(openLink), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
        
    }
 
    @objc func openLink(_ sender:UIButton)
    {
        let model = self.ratingArray[sender.tag]

        if let url = URL(string: model.author_url ?? "https://www.google.com/") {
            UIApplication.shared.open(url)
        }
    }
    
    
}

// MARK: - getHomeAPI Api Calls

extension RatingListVC
{
   
    func getPlaceIdAPI()
    {
        Indicator.shared.showIndicator()
        let name = locationDetail?.name ?? "name"
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(name)&key=AIzaSyDFPQu9rxw0T1FEkxpeTZMjOawBaqVcJzc"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
             AF.request(url).validate().responseJSON {
                response in
                     switch response.result {
                     case .success(let value):
                         print(value)
                        // print((((json as! JSONDictionary)["results"] as! JSONArray)[0] as! JSONDictionary)["place_id"] as! String)
                         if let json = value as? JSONDictionary, let result = json["results"] as? JSONArray
                         {
                             if result.count>0
                             {
                                 self.placeId = (result[0] as? JSONDictionary)?["place_id"] as? String ?? ""
                                 self.getPlaceReviewApiAPI()
                             }
                             print("Place id =\(self.placeId)")
                         }
                         Indicator.shared.hideIndicator()

                     case .failure(let error):
                         print(error)
                         Indicator.shared.hideIndicator()

                     }
                 
             }
        }
    }
    
    func getPlaceReviewApiAPI()
    {
           
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(self.placeId)&fields=name,rating,reviews&key=AIzaSyDFPQu9rxw0T1FEkxpeTZMjOawBaqVcJzc"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
             AF.request(url).validate().responseJSON {
                response in
                     switch response.result {
                     case .success(let value):
                         print(value)
                        // print((((json as! JSONDictionary)["results"] as! JSONArray)[0] as! JSONDictionary)["place_id"] as! String)
                         if let json = value as? JSONDictionary, let result = json["result"] as? JSONDictionary, let reviews = result["reviews"] as? JSONArray
                         {
                             
                             print("Place id reviews =\(reviews)")
                             self.parseData(data: reviews)
                         }
                     case .failure(let error):
                         print(error)
                     }             }
        }
    }
    func parseData(data:JSONArray)
    {
        
        for dict in data
        {
            let model = RatingModel(dict: dict)
            self.ratingArray.append(model)
        }
        self.tableDetails.reloadData()
        
    }
}
