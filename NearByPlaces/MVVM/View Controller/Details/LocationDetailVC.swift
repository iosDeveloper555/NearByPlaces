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
        self.tableDetails.estimatedRowHeight = 100
        self.tableDetails.rowHeight = UITableView.automaticDimension


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kDetailHTCell) as! DetailHTCell
            cell.selectedBackgroundView = bgColorView
            cell.imgDetails.setImageFromRemoteUrl(url: locationDetail?.location_image ?? "")
            cell.imgDetails.contentMode = .scaleAspectFit
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kDetailTitleCell) as! DetailTitleCell
            cell.selectedBackgroundView = bgColorView
            
            cell.lblName.text = locationDetail?.name
            cell.lblAddress.text = locationDetail?.filter
            cell.btnRating.addTarget(self, action: #selector(OpenRating), for: .touchUpInside)
            cell.btnNavigation.addTarget(self, action: #selector(OpenNavigation), for: .touchUpInside)

            return cell
        }
        else
            
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kDetailDescTCell) as! DetailDescTCell
            
            let attributedText = NSMutableAttributedString(string: "Beschreibung: ", attributes: [NSAttributedString.Key.font: UIFont(name: UIFont.CustomFont.Inter_Bold.rawValue, size: 18)! ])

            attributedText.append(NSAttributedString(string: (locationDetail?.description ?? kEmptyString).capitalized, attributes: [NSAttributedString.Key.font:  UIFont(name: UIFont.CustomFont.Inter_Regular.rawValue, size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "685F5F")]))
            
            cell.textDesc.attributedText = attributedText
            
            cell.selectedBackgroundView = bgColorView

            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0
        {
            return 234
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
        source.name = "Source"
                
        let lat = locationDetail?.latitude ?? "30.323"
        let lang = locationDetail?.longitude ?? "76.323"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lang)!)))
        destination.name = locationDetail?.address ?? "Destination"
                
        MKMapItem.openMaps(
          with: [source, destination],
          launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }

    
    
}

