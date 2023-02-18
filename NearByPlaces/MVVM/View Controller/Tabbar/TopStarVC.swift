//
//  TopStarVC.swift
//  NearByPlaces
//
//  Created by ios department on 12/16/22.
//

import UIKit

class TopStarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topStarInView: UIView!
    
    @IBOutlet weak var topStarTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStarInView.clipsToBounds = true
        topStarInView.layer.cornerRadius = 20
        topStarInView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        topStarTV.backgroundColor = UIColor.white
        topStarTV.delegate = self
        topStarTV.dataSource = self
      
        topStarTV.register(UINib.init(nibName: "TopStarTVCell", bundle: nil), forCellReuseIdentifier: "TopStarTVCell")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopStarTVCell", for: indexPath)
        
        
        return cell
    }
   
}
