//
//  DogBreedDetailVC.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class DogBreedDetailVC : UIViewController{
        
    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var dropdownView: UIView!
    
    var dogBreed : [DogBreedModel] = []
    var selectedIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breed"
        self.loadImage()
        self.addDropdownView()
    }
    
    private func loadImage(){
        NetworkManager.shared.getData(urlStr: dogBreed[selectedIndex].imageURL ?? "") { data, error in
            if let _data = data, let image = UIImage(data: _data){
                DispatchQueue.main.async {
                    self.breedImageView.image = image
                }
            }else{
                print("Error in download image")
            }
        }
    }
    
    private func addDropdownView(){
        let hostingController = UIHostingController(rootView: MenuView(items: dogBreed))
        self.dropdownView.addSubview(hostingController.view)
        
        hostingController.view.snp.makeConstraints { make in
            make.left.equalTo(dropdownView)
            make.right.equalTo(dropdownView)
            make.top.equalTo(dropdownView)
            make.bottom.equalTo(dropdownView)
        }
    }
    
    
}
