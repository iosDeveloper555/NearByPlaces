//
//  ListVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit

class ListVC: BaseVC {
    
    @IBOutlet weak var listAllInOneView: UIView!
    
    @IBOutlet weak var ListInView: UIView!
    
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var allImg: UIImageView!
    @IBOutlet weak var hotelsImg: UIImageView!
    @IBOutlet weak var strandeImg: UIImageView!
    @IBOutlet weak var baderImg: UIImageView!
        
    var filterArray:[Filter] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListInView.clipsToBounds = true
        ListInView.layer.cornerRadius = 20
        ListInView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        listTV.delegate = self
        listTV.dataSource = self
        listTV.backgroundColor = UIColor.white
        listTV.register(UINib.init(nibName: "ListTVCell", bundle: nil), forCellReuseIdentifier: "ListTVCell")
        self.showAllFiter()
        self.CallAPI()
        
    }
    
    @IBAction func allInBtnTapped(_ sender: UIButton) {
        
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
    
    @IBAction func hotelsBtnTapped(_ sender: UIButton) {
        
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
extension ListVC:UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeVM.shared.homeUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTVCell", for: indexPath) as! ListTVCell
        
        let cellData = HomeVM.shared.homeUserList[indexPath.row]
        
        cell.addressLbl.text=cellData.name
        cell.addressLocationLbl.text=cellData.address
        cell.kmLbl.text = self.getDistanceInKM(lat: cellData.latitude, lang: cellData.longitude)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationDetailVC") as! LocationDetailVC
        let cellData = HomeVM.shared.homeUserList[indexPath.row]
        
        vc.locationDetail=cellData
        self.navigationController?.pushViewController(vc, animated: true)
        
        //.modalPresentationStyle = .overFullScreen
        //self.present(vc, animated: true)
    }
}
// MARK: - getHomeAPI Api Calls

extension ListVC
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
            self.getHomeAPI(data: data)
            
            debugPrint(data)
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
                self.listTV.reloadData()
                debugPrint("Total user count =  \(count.count)")
            }
        })
    }
}
