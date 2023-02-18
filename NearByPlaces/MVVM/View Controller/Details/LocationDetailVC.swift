//
//  LocationDetailVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/19/22.
//

import UIKit

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
            cell.lblAddress.text = locationDetail?.address

            
            return cell
        }
        else
            
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: kDetailDescTCell) as! DetailDescTCell
            cell.textDesc.text = locationDetail?.description
            
            
            /*"2023-02-18 13:54:42.460131+0530 NearByPlaces[21673:347393] [Assert] UINavigationBar decoded as unlocked for UINavigationController, or navigationBar delegate set up incorrectly. Inconsistent configuration may cause problems. navigationController=<UINavigationController: 0x7f7e0b82a400>, navigationBar=<UINavigationBar: 0x7f7e0a20ca70; frame = (0 0; 0 50); opaque = NO; autoresize = W; layer = <CALayer: 0x6000019dd340>> delegate=0x7f7e0b82a400 2023-02-18 13:54:42.711446+0530 NearByPlaces[21673:347393] The behavior of the UICollectionViewFlowLayout is not defined because:2023-02-18 13:54:42.711647+0530 NearByPlaces[21673:347393] the item height must be less than the height of the UICollectionView minus the section insets top and bottom values, minus the content insets top and bottom values.2023-02-18 13:54:42.712257+0530 NearByPlaces[21673:347393] The relevant UICollectionViewFlowLayout instance is <UICollectionViewFlowLayout: 0x7f7e097258b0>, and it is attached to <UICollectionView: 0x7f7e0b028e00; frame = (0 0; 375 717); clipsToBounds = YES; autoresize = RM+BM; gestureRecognizers = <NSArray: 0x6000017e4690>; backgroundColor = UIExtendedGrayColorSpace 0 1; layer = <CALayer: 0x6000019ddd60>; contentOffset: {0, -20}; contentSize: {0, 0}; adjustedContentInset: {20, 0, 0, 0}; layout: <UICollectionViewFlowLayout: 0x7f7e097258b0>; dataSource: <NearByPlaces.ViewController: 0x7f7e0a30c740>>.2023-02-18 13:54:42.712334+0530 NearByPlaces[21673:347393] Make a symbolic breakpoint at UICollectionViewFlowLayoutBreakForInvalidSizes to catch this in the debugger."
             */

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
    
}

