//
//  TopStarVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit

class TopStarVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topStarInView: UIView!
    
    @IBOutlet weak var topStarTV: UITableView!
    var topListDataArray:[HomeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStarInView.clipsToBounds = true
        topStarInView.layer.cornerRadius = 20
        topStarInView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        topStarTV.backgroundColor = UIColor.white
        topStarTV.delegate = self
        topStarTV.dataSource = self
      
        topStarTV.register(UINib.init(nibName: "TopStarTVCell", bundle: nil), forCellReuseIdentifier: "TopStarTVCell")
        topStarTV.estimatedRowHeight=100
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.CallAPI()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topListDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopStarTVCell", for: indexPath) as! TopStarTVCell
        
        
        let model = topListDataArray[indexPath.row]
        cell.titleLblOutlet.text = model.state?.capitalized
        cell.lblDesc.text = model.name?.capitalized

        cell.imgOutlet.setImageFromRemoteUrl(url: model.top_ten ?? kEmptyString)

        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationDetailVC") as! LocationDetailVC
        let cellData = self.topListDataArray[indexPath.row]

        vc.locationDetail=cellData
        self.navigationController?.pushViewController(vc, animated: true)
        
        //.modalPresentationStyle = .overFullScreen
        //self.present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
}
// MARK: - TopStarVC Api Calls

extension TopStarVC
{
    func CallAPI(type:String=TYPE_ALL)
    {
        if Connectivity.isConnectedToInternet {
            var data = JSONDictionary()
            data[ApiKey.kType] = type
            data[ApiKey.kC_Latitude] = CURRENTLAT
            data[ApiKey.kC_Longitude] = CURRENTLONG

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
                self.topListDataArray.removeAll()
                for dict in count
                {
                    let top = dict.top_ten ?? kEmptyString
                    if top.count>0
                    {
                        self.topListDataArray.append(dict)
                    }
                    self.topStarTV.reloadData()
                }
            }
        })
    }
}
