//
//  BaseVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 05/01/23.
//

import UIKit
import CoreLocation
import Photos
import MobileCoreServices
import CoreTelephony

@objc protocol PickerDelegate {
    @objc optional func didSelectItem(at index: Int, item: String)
    @objc optional func didSelectDate(date: Date)
    @objc optional func didPickDocument(url: URL)
}


class BaseVC: UIViewController {

    //MARK:- Variables
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var pickerView = UIPickerView()
    var datePickerView = UIDatePicker()
    var pickerTextfield : UITextField!
    var pickerDelegate: PickerDelegate?
    var pickerArray = [String]()
    
    var startDate: Date?
    var startShaking = CFAbsoluteTimeGetCurrent()

    lazy var emptyview:EmptyScreenView = EmptyScreenView(image: self.imageForEmptyScreen, title: self.titleForEmptyScreen, description: self.descriptionForEmptyScreen)
    //
    @IBInspectable var imageForEmptyScreen:UIImage =  #imageLiteral(resourceName: "Intro1"){
        didSet {
            emptyview.imageView.image = imageForEmptyScreen
        }
    }
    @IBInspectable var titleForEmptyScreen:String = kEmptyList {
        didSet {
            emptyview.titleLabel.text = titleForEmptyScreen.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    @IBInspectable var descriptionForEmptyScreen:String = kEmptyList {
        didSet {
            emptyview.descriptionLabel.text = descriptionForEmptyScreen.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    //MARK: - Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.locale = Locale(identifier: "en_US_POSIX")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
       
    }
    func setHeader()
    {
        
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.red
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.red
        }
        
//    UIApplication.shared.statusBarStyle = .lightContent
//    UIApplication.shared.isStatusBarHidden = false
//    self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.barStyle = .default
//    self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.white//.AppColor.navBarColor.color()
//    self.navigationController?.navigationBar.isTranslucent = false
//self.navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .any, barMetrics: .default)
//    self.navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
//
//
    
        /*
    let titleButton = UIButton(frame: CGRect(x: 50, y:0, width:110, height:30))
    titleButton.titleLabel?.textAlignment = .center
    titleButton.setTitle(title, for: .normal)
    titleButton.isUserInteractionEnabled = false
    titleButton.titleEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 7, right: 0)
    titleButton.setTitleColor(UIColor.black, for: .normal)
    titleButton.titleLabel?.font = UIFont.CustomFont.regular.fontWithSize(size: 28.0)
    
    self.navigationItem.titleView = titleButton
    
    //Hide back button
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)


        
        if showBack {
            self.setBackButton()
        }
        else {
            self.navigationItem.hidesBackButton = true
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        if showMenuButton {
            self.setMenuButton()
        }
        
        */
        
    }
    func getStatusBarHeight() -> CGFloat {
       var statusBarHeight: CGFloat = 0
       if #available(iOS 13.0, *) {
           let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
           statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
       } else {
           statusBarHeight = UIApplication.shared.statusBarFrame.height
       }
       return statusBarHeight
   }

    func openSettings(message:String)
    {
        
        let alertController = UIAlertController (title: "Alert", message: message, preferredStyle: .alert)

           let settingsAction = UIAlertAction(title: "Ok", style: .default) { (_) -> Void in

               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }

               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                       print("Settings opened: \(success)") // Prints true
                   })
               }
           }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
           alertController.addAction(settingsAction)
           

        self.present(alertController, animated: true, completion: nil)
    }
    func showErrorMessage(error: Error?) {
        /*
         STATUS CODES:
         200: Success (If request sucessfully done and data is also come in response)
         204: No Content (If request successfully done and no data is available for response)
         401: Unauthorized (If token got expired)
         451: Block (If User blocked by admin)/delete by admin
         403: Delete (If User deleted by admin)
         406: Not Acceptable (If user is registered with the application but not verified)
         */
        let message = (error! as NSError).userInfo[ApiKey.kMessage] as? String ?? kSomethingWentWrong
        self.openSimpleAlert(message: message)
    }
    
    func openSimpleAlert(title:String="Alert!",message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func getDistanceInKM(lat:String?,lang:String?) -> String
    {
        let lat = lat ?? "30.323"
        let lang = lang ?? "76.323"
        
        let myLocation = CLLocation(latitude: CURRENTLAT, longitude: CURRENTLONG)

        //My buddy's location
        let myBuddysLocation = CLLocation(latitude: Double(lat)!, longitude: Double(lang)!)

        //Measuring my distance to my buddy's (in km)
        let distance = myLocation.distance(from: myBuddysLocation) / 1000

        //Display the result in km
        print(String(format: "%.01fkm", distance))
        return String(format: "%.01fkm", distance)
    }
    func getCurrentLocation(complition:@escaping (String)->Void)
    {
        let geocoder = CLGeocoder()
       let loc = CLLocation(latitude: CURRENTLAT, longitude: CURRENTLONG)
        geocoder.reverseGeocodeLocation(loc) { (placemarksArray, error) in
            var placemark:CLPlacemark!

            if (placemarksArray?.count)! > 0 {
                
                /*
                
                placemark = placemarksArray![0] as! CLPlacemark

                           var addressString : String = ""
                if placemark.isoCountryCode == "TW" /*Address Format in Chinese*/ {
                               if placemark.country != nil {
                                   addressString = placemark.country ?? kEmptyString
                               }
                               if placemark.subAdministrativeArea != nil {
                                   addressString = addressString + (placemark.subAdministrativeArea ?? kEmptyString) + ", "
                               }
                               if placemark.postalCode != nil {
                                   addressString = addressString + (placemark.postalCode ?? kEmptyString) + " "
                               }
                               if placemark.locality != nil {
                                   addressString = addressString + (placemark.locality ?? kEmptyString)
                               }
                               if placemark.thoroughfare != nil {
                                   addressString = addressString + (placemark.thoroughfare ?? kEmptyString)
                               }
                               if placemark.subThoroughfare != nil {
                                   addressString = addressString + (placemark.subThoroughfare ?? kEmptyString)
                               }
                           } else {
                               if placemark.subThoroughfare != nil {
                                   addressString = (placemark.subThoroughfare ?? kEmptyString) + " "
                               }
                               if placemark.thoroughfare != nil {
                                   addressString = addressString + (placemark.thoroughfare ?? kEmptyString) + ", "
                               }
                               if placemark.postalCode != nil {
                                   addressString = addressString + (placemark.postalCode ?? kEmptyString) + " "
                               }
                               if placemark.locality != nil {
                                   addressString = addressString + (placemark.locality ?? kEmptyString) + ", "
                               }
                               if placemark.administrativeArea != nil {
                                   addressString = addressString + (placemark.administrativeArea ?? kEmptyString) + " "
                               }
                               if placemark.country != nil {
                                   addressString = addressString + (placemark.country ?? kEmptyString)
                               }
                           }

                           print(addressString)
                    */
                
               let add = (((placemarksArray?.first?.addressDictionary as! NSDictionary)["FormattedAddressLines"] as? NSArray)?.componentsJoined(by: ","))
                complition(add ?? kEmptyString)
                
                debugPrint("address = \(placemarksArray)")
                
                
                
            }
        }

    }
    
}
//MARK: -  Hide/show empty view
extension BaseVC
{
    //    //MARK: Empty Screen Implementation
    func showEmptyScreen(belowSubview subview: UIView? = nil, superView:UIView? = nil,color:UIColor? = .black) {
        let baseView: UIView = superView ?? self.view
        emptyview.frame = CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height)
        emptyview.titleLabel.textColor = color
        emptyview.descriptionLabel.textColor = color
        self.view.isUserInteractionEnabled = true
        emptyview.isUserInteractionEnabled = false
        if let subview = subview {
            baseView.insertSubview(emptyview, belowSubview: subview)
        }
        else {
            
            baseView.addSubview(emptyview)
        }
        baseView.backgroundColor=UIColor.red
    }
    
    func hideEmptyScreen() {
        emptyview.removeFromSuperview()
    }
}
extension UIColor {
    //TO REMOVE THE NAVIGATION BAR LINE
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
extension BaseVC {
    
    func showImagePicker(showVideo: Bool = false, showDocument: Bool = false) {
        let alert  = UIAlertController(title: "SELECT MEDIA", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "GALLERY", style: .default, handler: {action in
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined || photos == .denied || photos == .restricted {
                PHPhotoLibrary.requestAuthorization({status in
                    DispatchQueue.main.async {
                        if status == .authorized {
                            CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery, showVideo: showVideo)
                        }
                        else {
                            // self.showAlert(message: "Please enable the library permission from the settings.", {
                            self.openSettings(message: "Please enable the library permission from the settings.")
                            // }//)
                            return
                        }
                    }
                })
            }
            else {
                CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery, showVideo: showVideo)
            }
        }))
        alert.addAction(UIAlertAction(title: "CAMERA", style: .default, handler: {action in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                DispatchQueue.main.async {
                    if response {
                        CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .camera, showVideo: showVideo)
                    } else {
                        //                       // self.showAlert(message: "Please enable the camera permission from the settings.", {
                        //                            self.openSettings()
                        self.openSettings(message: "Please enable the camera permission from the settings.")
                        //                        })
                        return
                    }
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            alert.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad
            
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func openGallery() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined || photos == .denied || photos == .restricted {
            PHPhotoLibrary.requestAuthorization({status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery)
                    }
                    else {
                   
                        self.openSettings(message: "Please enable the library permission from the settings.")
                        return
                    }
                }
            })
        }
        else {
            CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery)
        }
    }
    
    
}



extension BaseVC: UIPickerViewDelegate,UIPickerViewDataSource {
    
    //MARK: Custom Picker Methods
    func setPickerView(textField: UITextField, array: [String], selectedIndex: Int = 0) {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerArray = array
        pickerTextfield = textField
        
        //Set Picker View to Textfield
        textField.inputView = pickerView
        textField.text = pickerArray[selectedIndex]
        pickerView.reloadAllComponents()
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
    
    // Delegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerDelegate?.didSelectItem?(at: row, item: pickerArray[row])
       
        self.pickerTextfield.text = pickerArray[row]
        
    }
    
    //MARK: Custom Date Picker
    func setDatePicker(textField: UITextField, datePickerMode: UIDatePicker.Mode = .dateAndTime, maximunDate: Date? = nil, minimumDate: Date? = Date()) {
        textField.inputView = datePickerView
        pickerTextfield = textField
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        datePickerView.datePickerMode = datePickerMode
        datePickerView.timeZone = NSTimeZone.local
        datePickerView.backgroundColor = UIColor.lightGray
        
        let calendar = Calendar(identifier: .gregorian)

           let currentDate = Date()
           var components = DateComponents()
           components.calendar = calendar

           components.year = -18
           components.month = 12
           let maxDate = calendar.date(byAdding: components, to: currentDate)!

           components.year = -100
           let minDate = calendar.date(byAdding: components, to: currentDate)!

        
        datePickerView.maximumDate = maxDate
        datePickerView.minimumDate = minDate
        datePickerView.locale = Locale(identifier: "en_US_POSIX")
        datePickerView.addTarget(self, action: #selector(self.didDatePickerViewValueChanged(sender:)), for: .valueChanged)
        
        
    }
    
    
    @objc func didDatePickerViewValueChanged(sender: UIDatePicker) {
       pickerDelegate?.didSelectDate?(date: sender.date)
    }
    

}

