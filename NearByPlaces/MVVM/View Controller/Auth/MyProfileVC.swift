//
//  MyProfileVC.swift
//  NearByPlaces
//
//  Created by Amarendra on 11/03/23.
//

import UIKit

class MyProfileVC: BaseVC {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLang: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAct(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func AddImageAct(_ sender: UIButton)
    {
        self.showImagePicker(showVideo: false, showDocument: false)
        
        CustomImagePickerView.sharedInstace.delegate = self
    }


    @IBAction func userNameEditAct(_ sender: UIButton)
    {
        
    }
    @IBAction func phoneEditAct(_ sender: UIButton)
    {
        
    }
    @IBAction func ageEditAct(_ sender: UIButton)
    {
        
    }
    @IBAction func languageEditAct(_ sender: UIButton)
    {
        
    }
}
//MARK: - CustomImagePickerDelegate

extension MyProfileVC:CustomImagePickerDelegate
{
    
    func didImagePickerFinishPicking(_ image: UIImage)
    {
        self.imgProfile.image = image
    }
}
