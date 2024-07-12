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
        
    @IBOutlet weak var carouselViewContainer: UIView!
    @IBOutlet weak var dropdownView: UIView!
    
    var viewModel = DogBreedDetailViewModel()
    var carouselView : CarouselView?
    var menuView : MenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breed"
        self.addDropdownView()
        self.addCarouselView()
    }
    
    /*private func loadImage(){
        NetworkManager.shared.getData(urlStr: self.viewModel.dogBreed[self.].imageURL ?? "") { data, error in
            if let _data = data, let image = UIImage(data: _data){
                DispatchQueue.main.async {

                }
            }else{
                print("Error in download image")
            }
        }
    }*/
    
    private func addDropdownView(){
        let menuView = MenuView(viewModel: MenuViewModel(items: self.viewModel.dogBreed)) { [weak self] model,index in
            self?.updateCarouselView(breed: model,index : index)
        }
        self.menuView = menuView
        let hostingController = UIHostingController(rootView: menuView)
        self.dropdownView.addSubview(hostingController.view)
        
        hostingController.view.snp.makeConstraints { make in
            make.left.equalTo(dropdownView)
            make.right.equalTo(dropdownView)
            make.top.equalTo(dropdownView)
            make.bottom.equalTo(dropdownView)
        }
    }
    
    private func addCarouselView(){
        let carouselView = CarouselView(viewModel: CarouselViewModel(items: self.viewModel.createCarouselModel())) { [weak self] selectedIndex in
            self?.updateDropdownView(index: selectedIndex)
        }
        self.carouselView = carouselView
        let carouselHostingController = UIHostingController(rootView: carouselView)
        self.carouselViewContainer.addSubview(carouselHostingController.view)
        
        carouselHostingController.view.snp.makeConstraints { make in
            make.left.equalTo(carouselViewContainer)
            make.right.equalTo(carouselViewContainer)
            make.top.equalTo(carouselViewContainer)
            make.bottom.equalTo(carouselViewContainer)
        }
    }
    
    private func updateCarouselView(breed : DogBreedModel,index : Int){
        self.carouselView?.updateImage(index: index)
    }
    
    private func updateDropdownView(index : Int){
        let selectedValue = self.viewModel.dogBreed[index].name
        self.menuView?.updateDropdownText(text: selectedValue)
    }
    
}
