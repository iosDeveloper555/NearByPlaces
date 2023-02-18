//
//  UIImage+Extension.swift
//  NearByPlaces
//
//  Created by Amarendra on 17/02/23.
//

import Foundation
import Kingfisher

extension UIImageView{
    
    func setImageFromRemoteUrl(url:String, placeholderImage:String = "NoImage", downsamplingSize:CGSize? = nil, completion: ((RetrieveImageResult?) -> Void)? = nil){
        
        var placeholder:UIImage?
        if placeholderImage != "", let image = UIImage.init(named: placeholderImage){
            placeholder = image
        }
        
        let url = URL.init(string: IMAGE_BASE_URL+url)
        let processor = DownsamplingImageProcessor(size: downsamplingSize ?? self.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder == nil ? UIImage() : placeholder!,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
              //  print("Task done for: \(value.source.url?.absoluteString ?? "")")
                completion?(value)
            case .failure(let error):
               // print("Job failed: \(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
}
