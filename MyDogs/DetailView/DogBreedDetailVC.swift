//
//  DogBreedDetailVC.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import Foundation
import UIKit

class DogBreedDetailVC : UIViewController{
        
    @IBOutlet weak var breedImageView: UIImageView!
    
    var imageURL : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breed"
        self.loadImage()
    }
    
    private func loadImage(){
        NetworkManager.shared.getData(urlStr: imageURL) { data, error in
            if let _data = data, let image = UIImage(data: _data){
                DispatchQueue.main.async {
                    self.breedImageView.image = image
                }
            }else{
                print("Error in download image")
            }
        }
    }
    
    
}
