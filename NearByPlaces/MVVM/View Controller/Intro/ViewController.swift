//
//  ViewController.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit
import CoreLocation

class ViewController: BaseVC {


    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pagerOutlet: UIPageControl!
    var currentpage = 0
    
    var selectedIndex = 1
    let imageArray: [UIImage] = [UIImage(named: "Intro1")!,UIImage(named: "Intro2")!,UIImage(named: "Intro3")!,]
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.setHeader()
        self.pagerOutlet.transform = CGAffineTransform(scaleX: 1.3, y: 1.3); //set value here

        setUPCollection()
        pagerOutlet.numberOfPages = self.imageArray.count
    }
//    override func viewWillAppear(_ animated: Bool) {
//        UIApplication.shared.isStatusBarHidden = true
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        UIApplication.shared.isStatusBarHidden = false
//
//    }
  
    @IBAction func skipBtnOutlet(_ sender: UIButton) {
        sender.animateButtonUp()

     SCENEDEL?.navigateToLogin()//navigateToHome() //
        
    }
    
    @IBAction func nextBtnOutlet(_ sender: UIButton) {
        sender.animateButtonUp()
        if self.currentpage < 2{
           // let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + SCREENWIDTH))
           // self.manager.requestLocation()
            self.moveCollectionToFrame(contentOffset: contentOffset)

        }else{
            
            SCENEDEL?.navigateToLogin()//.navigateToHome()
        }
    }
    

    func moveCollectionToFrame(contentOffset : CGFloat)
    {

        let size = self.collectionView.frame.size

        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : size.width,height : size.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }

    
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
   
    
    func setUPCollection()
    {
        self.collectionView.delegate=self
        self.collectionView.dataSource=self
        self.collectionView.registerColletionCell(identifier: kIntrollCCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIntrollCCell, for: indexPath) as! IntrollCCell
        cell.img.image = self.imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        pagerOutlet.currentPage = index
        currentpage  = index
        
        if index == 2
        {
            SCENEDEL?.navigateToLogin()//navigateToHome()

        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pagerOutlet.currentPage = indexPath.row
        currentpage  =  indexPath.row
    }
}
