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
    
    var imageCache = NSCache<AnyObject,AnyObject>()
    
    func loadImage(url : String){
        
        if let url = URL(string: url){
            SDWebImageDownloader.shared.downloadImage(with: url,options: .useNSURLCache,progress: {_,_,_ in }) { image, data, error, isFinished in
                if error == nil && image != nil{
                    self.image = image
                }else{
                    print("Error in downloding")
                }
            }
        }
    }
}
