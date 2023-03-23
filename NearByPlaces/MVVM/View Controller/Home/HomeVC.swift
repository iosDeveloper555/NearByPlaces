//
//  HomeVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit
import Alamofire
import GoogleMaps
import CoreLocation

class HomeVC: BaseVC {
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var allInView: UIView!
    
    @IBOutlet weak var allImg: UIImageView!
    @IBOutlet weak var hotelsImg: UIImageView!
    @IBOutlet weak var strandeImg: UIImageView!
    @IBOutlet weak var baderImg: UIImageView!
    
    var selectAllImg = true
    var selectHotelImg = true
    var selectStrandeImg = true
    var selectBaderImg = true
    
    let manager = CLLocationManager()
    var permissionLocationCheck:Bool = false
    var selectedTopIndex:[Int] = []
    
    var filterArray:[Filter] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        self.showAllFiter()
        self.CallAPI()
        
        self.LocationSetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint(#function)
        self.selectedTopIndex.removeAll()
        UIApplication.shared.statusBarStyle = .darkContent
        
        self.CheckLocationPermission()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    @IBAction func selectAllBtnTapped(_ sender: UIButton) {
        
        if  self.filterArray.count >= 3
        {
            self.filterArray.removeAll()
            
        }
        else
        {
            if !self.filterArray.contains(.TYPE_SS)
            {
                self.filterArray.append(.TYPE_SS)
            }
            if !self.filterArray.contains(.TYPE_HC)
            {
                self.filterArray.append(.TYPE_HC)
            }
            if !self.filterArray.contains(.TYPE_BS)
            {
                self.filterArray.append(.TYPE_BS)
            }
            
        }
        
        self.showSelectStatus()
        self.CallAPI()
    }
    
    @IBAction func hotelsAndCampingBtnTapped(_ sender: UIButton) {
        
        if self.filterArray.contains(.TYPE_HC)
        {
            self.filterArray.removeAll { name in
                name.rawValue == TYPE_HC
            }
            hotelsImg.image = UIImage(named: "Hotels-&-Camping-Grey 1")
            
        }
        else
        {
            self.filterArray.append(.TYPE_HC)
            hotelsImg.image = UIImage(named: "Hotels-&-Camping- Act")
            
        }
        showSelectStatus()
        self.CallAPI(type: TYPE_HC)
        
    }
    
    @IBAction func strandeBtnTapped(_ sender: UIButton) {
        
        if self.filterArray.contains(.TYPE_SS)
        {
            self.filterArray.removeAll { name in
                name.rawValue == TYPE_SS
            }
            strandeImg.image = UIImage(named: "Strände-&-Seen-Grey 1")
            
        }
        else
        {
            self.filterArray.append(.TYPE_SS)
            strandeImg.image = UIImage(named: "Str„nde-&-Seen- Act")
            
        }
        showSelectStatus()
        self.CallAPI(type: TYPE_SS)
        
    }
    
    @IBAction func baderBtnTapped(_ sender: UIButton) {
        if self.filterArray.contains(.TYPE_BS)
        {
            self.filterArray.removeAll { name in
                name.rawValue == TYPE_BS
            }
            baderImg.image = UIImage(named: "Bäder-&-Saunen--greypng 1")
            
        }
        else
        {
            self.filterArray.append(.TYPE_BS)
            baderImg.image = UIImage(named: "B„der-&-Saunen Act")
            
        }
        showSelectStatus()
        self.CallAPI(type: TYPE_BS)
        
    }
    
    func showSelectStatus()
    
    {
        if self.filterArray.count >= 3
        {
            allImg.image = UIImage(named: "ALL-IN- 1")
            hotelsImg.image = UIImage(named: "Hotels-&-Camping- Act")
            strandeImg.image = UIImage(named: "Str„nde-&-Seen- Act")
            baderImg.image = UIImage(named: "B„der-&-Saunen Act")
            
        }
        else if self.filterArray.count == 0
        {
            allImg.image = UIImage(named: "ALL-IN-non Act")
            hotelsImg.image = UIImage(named: "Hotels-&-Camping-Grey 1")
            
            strandeImg.image = UIImage(named: "Strände-&-Seen-Grey 1")
            
            baderImg.image = UIImage(named: "Bäder-&-Saunen--greypng 1")
            
        }
        else
        {
            allImg.image = UIImage(named: "ALL-IN-non Act")
            
        }
    }
    
    func showAllFiter()
    {
        if !self.filterArray.contains(.TYPE_SS)
        {
            self.filterArray.append(.TYPE_SS)
        }
        if !self.filterArray.contains(.TYPE_HC)
        {
            self.filterArray.append(.TYPE_HC)
        }
        if !self.filterArray.contains(.TYPE_BS)
        {
            self.filterArray.append(.TYPE_BS)
        }
        self.showSelectStatus()
        
    }
    
    
}

// MARK: - getHomeAPI Api Calls

extension HomeVC
{
    func CallAPI(type:String=TYPE_ALL)
    {
        if Connectivity.isConnectedToInternet {
            var data = JSONDictionary()
            if self.filterArray.count>0
            {
                data[ApiKey.kType] = self.filterArray.map({ fil in
                    fil.rawValue
                }).joined(separator: ",")
                
            }
            else
            {
                data[ApiKey.kType] = type
                
            }
            data[ApiKey.kC_Latitude] = CURRENTLAT
            data[ApiKey.kC_Longitude] = CURRENTLONG

            print(data)
            
            self.getHomeAPI(data: data)
        } else {
            
            self.openSimpleAlert(message: APIManager.INTERNET_ERROR)
        }
    }
    func getHomeAPI(data:JSONDictionary)
    {
        HomeVM.shared.callApiForHomeData(data: data, response: { (message, error) in
            
            if error != nil
            {
                self.showErrorMessage(error: error)
            }
            else{
                
                let count = HomeVM.shared.homeUserList
                debugPrint("Total user count =  \(count.count)")
                self.showAllMarker()
            }
        })
    }
    
    //MARK: =  Show all marker
    func showAllMarker()
    {
        mapView.clear()
        
        for i  in 0..<HomeVM.shared.homeUserList.count
        {
            let dict = HomeVM.shared.homeUserList[i]
            
            let lat = dict.latitude ?? "30.323"
            let lang = dict.longitude ?? "76.323"
            
            let camera = GMSCameraPosition.camera(withLatitude: Double(lat)!, longitude: Double(lang)!, zoom: 12.0)
            
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lang)!))
            marker.title = dict.name
            marker.snippet = dict.address
            marker.userData = [ApiKey.kId:i]
            //marker.setValue("\(i)", forKey: ApiKey.kId)
            
            marker.map = self.mapView
            self.mapView.animate(to: camera)
        }
    }
}
//MARK: - set map for location

extension HomeVC:GMSMapViewDelegate
{
    //    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    //        debugPrint(#function)
    //
    //        return true
    //    }
    
    
    
    
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        debugPrint(#function)
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        debugPrint(#function)
        debugPrint(marker.title)
        debugPrint(marker.userData)
        
        if let dict = marker.userData as? JSONDictionary, let index = dict[ApiKey.kId] as? Int
        {
            if  HomeVM.shared.homeUserList.count>index
            {
                let vc = LocationDetailVC.instantiate(fromAppStoryboard: .Tabbar)
                vc.locationDetail=HomeVM.shared.homeUserList[index]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        //debugPrint(marker.value(forKey: ApiKey.kId))
        
    }
}

//MARK: - Get current location

extension HomeVC: CLLocationManagerDelegate
{
    
    func LocationSetup()
    {
        self.manager.requestAlwaysAuthorization()
        self.manager.delegate = self
        self.manager.requestLocation()
        self.manager.startUpdatingLocation()
        
        self.mapView.isMyLocationEnabled = true
        
        let camera = GMSCameraPosition.camera(withLatitude: (CURRENTLAT), longitude: (CURRENTLONG), zoom: 17.0)
        self.mapView.animate(to: camera)
        // self.mapView.settings.myLocationButton = true
        self.mapView.settings.compassButton = true
        
        
    }
    
    func CheckLocationPermission()
    {
        //        DispatchQueue.main.async {
        //            if CLLocationManager.locationServicesEnabled()
        //            {
        //                switch CLLocationManager.authorizationStatus() {
        //                case .notDetermined, .restricted, .denied:
        //                    print("No access")
        //                    self.permissionLocationCheck=false
        //                //self.openSettings(message: kLocation)
        //                case .authorizedAlways, .authorizedWhenInUse:
        //                    print("Access")
        //                    self.permissionLocationCheck=true
        //                @unknown default:
        //                    break
        //                }
        //            } else {
        //                print("Location services are not enabled")
        //                self.permissionLocationCheck=false
        //                //self.openSettings(message: kLocation)
        //            }
        //            if self.permissionLocationCheck==false
        //            {
        //                self.openSettings(message: kLocation)
        //            }
        /// }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first
        {
            print("Found user's location: \(location)")
            CURRENTLAT=location.coordinate.latitude
            CURRENTLONG=location.coordinate.longitude
            
            let camera = GMSCameraPosition.camera(withLatitude: CURRENTLAT, longitude: CURRENTLONG, zoom: 12.0)
            
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CURRENTLAT, longitude: CURRENTLONG))
            marker.title = "Current Location"//location.description
            // marker.snippet = "Sec 132 Noida India"
            marker.map = self.mapView
            self.mapView.animate(to: camera)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
