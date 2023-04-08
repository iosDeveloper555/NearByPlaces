//
//  LocationDetailVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/19/22.
//

import UIKit
import CoreLocation
import MapKit

class LocationDetailVC: BaseVC {
    

    @IBOutlet weak var tableDetails: UITableView!
    var locationDetail:HomeModel?
    var cellArray:[DetailCellType] = []
    
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
extension LocationDetailVC:UITableViewDelegate,UITableViewDataSource
{
  
    func setUpTableView()
    {
        self.tableDetails.delegate=self
        self.tableDetails.dataSource=self
        self.tableDetails.registerTableCell(identifier: kDetailHTCell)
        self.tableDetails.registerTableCell(identifier: kDetailTitleCell)
        self.tableDetails.registerTableCell(identifier: kDetailDescTCell)
        self.tableDetails.registerTableCell(identifier: kCommentTCell)
        self.tableDetails.registerTableCell(identifier: kCommentMoreTCell)
        self.tableDetails.registerTableCell(identifier: kReviewTCell)

        
        self.tableDetails.estimatedRowHeight = 100
        self.tableDetails.rowHeight = UITableView.automaticDimension
        self.cellArray.append(.HeaderImage)
        self.cellArray.append(.Title)
        self.cellArray.append(.Description)
        self.cellArray.append(.Comment)
        self.cellArray.append(.Comment)
        self.cellArray.append(.MoreComment)
        self.cellArray.append(.Review)



    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cellArray.count//3+2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        let cellType = self.cellArray[indexPath.row]
        
        if cellType == .HeaderImage
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kDetailHTCell) as! DetailHTCell
            cell.selectedBackgroundView = bgColorView
            cell.imgDetails.setImageFromRemoteUrl(url: locationDetail?.location_image ?? "")
            cell.imgDetails.contentMode = .scaleAspectFit
            return cell
        }
        else if cellType == .Title
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kDetailTitleCell) as! DetailTitleCell
            cell.selectedBackgroundView = bgColorView
            
            cell.lblName.text = locationDetail?.name
            cell.lblAddress.text = locationDetail?.filter
            cell.btnRating.addTarget(self, action: #selector(OpenRating), for: .touchUpInside)
            cell.btnNavigation.addTarget(self, action: #selector(OpenNavigation), for: .touchUpInside)
            cell.btnWebLink.addTarget(self, action: #selector(OpenWebLink), for: .touchUpInside)
            
            return cell
            
        }
        else if cellType == .Description
            
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kDetailDescTCell) as! DetailDescTCell
            
            let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont(name: UIFont.CustomFont.Inter_Bold.rawValue, size: 18)! ])
//Beschreibung:
            attributedText.append(NSAttributedString(string: (locationDetail?.description ?? kEmptyString).capitalized, attributes: [NSAttributedString.Key.font:  UIFont(name: UIFont.CustomFont.Inter_Regular.rawValue, size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.black]))
            
            cell.textDesc.attributedText = attributedText
            
            cell.selectedBackgroundView = bgColorView

            return cell

        }
        else if cellType == .Comment
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCommentTCell) as! CommentTCell
            cell.selectedBackgroundView = bgColorView
         
            return cell
        }
        else if cellType == .MoreComment
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCommentMoreTCell) as! CommentMoreTCell
            cell.selectedBackgroundView = bgColorView
            cell.btnMoreComment.addTarget(self, action: #selector(moreCommentAct), for: .touchUpInside)

         
            return cell
        }
        else //if cellType == .MoreComment
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kReviewTCell) as! ReviewTCell
            cell.selectedBackgroundView = bgColorView

         
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let cellType = self.cellArray[indexPath.row]

        if cellType == .HeaderImage
        {
            return 234
        }
        else  if cellType == .MoreComment
        {
            return 50
        }
        else  if cellType == .Review
        {
            return 190
        }
       
        return UITableView.automaticDimension
        
    }
    
    //MARK: - OpenRating
    @objc func OpenRating(_ sender:UIButton)
    {
       let vc = RatingListVC.instantiate(fromAppStoryboard: .Tabbar)
        vc.locationDetail = self.locationDetail
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //MARK: - OpenNavigation
    @objc func OpenNavigation(_ sender:UIButton)
    {
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CURRENTLAT, longitude: CURRENTLONG)))
        self.getCurrentLocation { location in
            source.name = location
            let lat = self.locationDetail?.latitude ?? "30.323"
            let lang = self.locationDetail?.longitude ?? "76.323"
            
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lang)!)))
            destination.name = self.locationDetail?.address ?? "Destination"
                    
            MKMapItem.openMaps(
              with: [source, destination],
              launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            )

        }
                
      
    }
    //MARK: - OpenWebLink
    @objc func OpenWebLink(_ sender:UIButton)
    {
        guard let requestUrl = NSURL(string: self.locationDetail?.url ?? kEmptyString) else {
            return
        }

        UIApplication.shared.openURL(requestUrl as URL)
        
        
    }

    //MARK: - moreCommentAct
    @objc func moreCommentAct(_ sender:UIButton)
    {
        let vc = CommentListVC.instantiate(fromAppStoryboard: .Tabbar)
         vc.locationDetail = self.locationDetail
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

