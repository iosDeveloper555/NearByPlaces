//
//  ListVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit

class ListVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var listAllInOneView: UIView!
    
    @IBOutlet weak var ListInView: UIView!
   
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var allImg: UIImageView!
    @IBOutlet weak var hotelsImg: UIImageView!
    @IBOutlet weak var strandeImg: UIImageView!
    @IBOutlet weak var baderImg: UIImageView!
    
    var selectedTopIndex:[Int] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListInView.clipsToBounds = true
        ListInView.layer.cornerRadius = 20
        ListInView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        listTV.delegate = self
        listTV.dataSource = self
        listTV.backgroundColor = UIColor.white
        listTV.register(UINib.init(nibName: "ListTVCell", bundle: nil), forCellReuseIdentifier: "ListTVCell")

        self.selectedTopIndex.removeAll()
        self.CallAPI()

    }
    
    @IBAction func allInBtnTapped(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//
//        if sender.isSelected{
//            allImg.image = UIImage(named: "ALL-IN- 1")
//        }else{
//            allImg.image = UIImage(named: "ALL-IN-non Act")
//        }
//
        if  self.selectedTopIndex.count >= 3
        {
            self.selectedTopIndex.removeAll()
            
        }
        else
        {
            if !self.selectedTopIndex.contains(1)
            {
                self.selectedTopIndex.append(1)
            }
            if !self.selectedTopIndex.contains(2)
            {
                self.selectedTopIndex.append(2)
            }
            if !self.selectedTopIndex.contains(3)
            {
                self.selectedTopIndex.append(3)
            }

        }
        self.showSelectStatus()
        self.CallAPI()

    }
    
    @IBAction func hotelsBtnTapped(_ sender: UIButton) {
        if !self.selectedTopIndex.contains(1)
        {
            self.selectedTopIndex.append(1)
            hotelsImg.image = UIImage(named: "Hotels-&-Camping- Act")

        }
   // }
else{
        if let index = self.selectedTopIndex.firstIndex(of: 1)
        {
            self.selectedTopIndex.remove(at: index)
        }
        hotelsImg.image = UIImage(named: "Hotels-&-Camping-Grey 1")
    }
    showSelectStatus()
        self.CallAPI(type: TYPE_HC)

    }
    
    @IBAction func strandeBtnTapped(_ sender: UIButton) {
        if !self.selectedTopIndex.contains(2)
        {
            self.selectedTopIndex.append(2)
            strandeImg.image = UIImage(named: "Str„nde-&-Seen- Act")

        }
   // }
else{
        if let index = self.selectedTopIndex.firstIndex(of: 2)
        {
            self.selectedTopIndex.remove(at: index)
        }
        strandeImg.image = UIImage(named: "Strände-&-Seen-Grey 1")
    }
    showSelectStatus()
        self.CallAPI(type: TYPE_SS)

    }
    
    @IBAction func baderBtnTapped(_ sender: UIButton) {
    
        if !self.selectedTopIndex.contains(3)
        {
            self.selectedTopIndex.append(3)
            baderImg.image = UIImage(named: "B„der-&-Saunen Act")

        }
    //}
else{
        if let index = self.selectedTopIndex.firstIndex(of: 3)
        {
            self.selectedTopIndex.remove(at: index)
        }
        baderImg.image = UIImage(named: "Bäder-&-Saunen--greypng 1")
    }
    showSelectStatus()
        self.CallAPI(type: TYPE_BS)

    }
    
    func showSelectStatus()
    
    {
        print(self.selectedTopIndex)
        if self.selectedTopIndex.count >= 3
        {
            allImg.image = UIImage(named: "ALL-IN- 1")
            hotelsImg.image = UIImage(named: "Hotels-&-Camping- Act")
            strandeImg.image = UIImage(named: "Str„nde-&-Seen- Act")
            baderImg.image = UIImage(named: "B„der-&-Saunen Act")

        }
        else if self.selectedTopIndex.count == 0
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
            data[ApiKey.kType] = type
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
                self.listTV.reloadData()
                debugPrint("Total user count =  \(count.count)")
            }
        })
    }
}
