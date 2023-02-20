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
    var locationDetail:HomeModel?
    
    var placeId = "ChIJ1Z6WLW77mUcRLDKrwySdu14"
    var ratingArray:[RatingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()

            if Connectivity.isConnectedToInternet {
        
                self.getPlaceIdAPI()
            } else {
                
                self.openSimpleAlert(message: APIManager.INTERNET_ERROR)
            }
        

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
        cell.lblReview.text = "\(model.rating ?? 0)"
        cell.lblAccountLink.text=model.author_url
        cell.txtDesc.text = model.text
        cell.imgProfile.setImageFromRemoteUrl(type: .Google,url: model.profile_photo_url ?? kEmptyString)

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

// MARK: - getHomeAPI Api Calls

extension RatingListVC
{
   
    func getPlaceIdAPI()
    {
           
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
                     case .failure(let error):
                         print(error)
                     }             }
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
