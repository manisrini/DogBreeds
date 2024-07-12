//
//  CustomImageView.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import Foundation
import UIKit
import SDWebImage

class CustomImageView : UIImageView{
        
    func loadImage(url : String){
        
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_imageTransition = .flipFromTop
        
        if let url = URL(string: url){
            let placeholderImage = UIImage(named: "thumbnail")
            self.sd_setImage(with: url) { image, error, type, url in
                if error != nil{
                    self.image = placeholderImage
                }
            }
        }
    }
}
