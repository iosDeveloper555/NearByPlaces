//
//  LocationVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit
import DropDown
import CoreLocation
import Alamofire


class LocationVC: UIViewController {

    @IBOutlet weak var addPlaceInView: UIView!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewDesc: UIView!
    @IBOutlet weak var viewAll: UIView!

    
    @IBOutlet weak var allTxt: UITextField!

    @IBOutlet weak var addressTxtView: GrowingTextView!
    
    @IBOutlet weak var descriptionTxtView: GrowingTextView!
    
    @IBOutlet weak var addPlaceBtnOutlet: UIButton!
    
    var optionArray = ["Strande & Seen","Bader & Saunen","Hotels & Camping"]
    let dropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        addPlaceInView.clipsToBounds = true
        addPlaceInView.layer.cornerRadius = 20
        addPlaceInView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        cityTxt.layer.cornerRadius = 10
        //cityTxt.layer.borderWidth = 1
       // cityTxt.layer.borderColor = UIColor.lightGray.cgColor
        
        self.cityTxt.addDashedBorder()
        
//        allInTxt.layer.cornerRadius = 10
//        allInTxt.layer.borderWidth = 1
//        allInTxt.layer.borderColor = UIColor.lightGray.cgColor
//        addressTxtView.layer.cornerRadius = 10
//        addressTxtView.backgroundColor = UIColor.white
//        addressTxtView.layer.borderWidth = 1
        
       // addressTxtView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTxtView.layer.cornerRadius = 10
        descriptionTxtView.backgroundColor = UIColor.white
       // descriptionTxtView.layer.borderWidth = 1
       // descriptionTxtView.layer.borderColor = UIColor.lightGray.cgColor
        addPlaceBtnOutlet.layer.cornerRadius = 10
        
       // self.addPlaceBtnOutlet.addDashedBorder()
        self.viewAddress.addDashedBorder()
        self.viewDesc.addDashedBorder()
        self.viewAll.addDashedBorder()


        dropDown.anchorView = self.allTxt
        dropDown.dataSource = optionArray
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.dropDown.hide()
            self.allTxt.text = item
        }
        
        addressTxtView.delegate=self
        descriptionTxtView.delegate=self
        self.getCurrentLocation()
    }
    @IBAction func cityBtnOutlet(_ sender: UIButton) {
        print(#function)
        dropDown.show()
    }
    

  
}
extension LocationVC:UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // as @nhgrif suggested, we can skip the string manipulations if
        // the beginning of the textView.text is not touched.
        guard range.location == 0 else {
            return true
        }

        let newString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
        return newString.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines).location != 0
    }

}

extension LocationVC
{
    func getCurrentLocation()
    {
        let geocoder = CLGeocoder()
       let loc = CLLocation(latitude: CURRENTLAT, longitude: CURRENTLONG)
        geocoder.reverseGeocodeLocation(loc) { (placemarksArray, error) in

            if (placemarksArray?.count)! > 0 {
               let add = (((placemarksArray?.first?.addressDictionary as! NSDictionary)["FormattedAddressLines"] as? NSArray)?.componentsJoined(by: ","))
                
                self.addressTxtView.text = add
            }
        }

    }
}
