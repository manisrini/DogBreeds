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
    @IBOutlet weak var messageLbl: UILabel!
    
    var viewModel = DogBreedDetailViewModel()
    var carouselView : CarouselView?
    var menuView : MenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addStyles()
        self.addDropdownView()
        self.addCarouselView()
        self.updateMessage(name: viewModel.getName(index: viewModel.selectedIndex))
    }
    
    private func addStyles(){
        self.messageLbl.font = UIFont(name: "Roboto-Medium", size: 16)
        self.carouselViewContainer.layer.borderColor = UIColor.lightGray.cgColor
        self.carouselViewContainer.layer.cornerRadius = 10
        self.carouselViewContainer.layer.borderWidth = 2
        self.carouselViewContainer.layer.borderColor = UIColor.lightGray.cgColor
    }
        
    private func addDropdownView(){
        let menuView = MenuView(viewModel: MenuViewModel(items: self.viewModel.dogBreed,dropdownText: viewModel.getName(index: self.viewModel.selectedIndex))) { [weak self] model,index in
            self?.updateCarouselView(breed: model,index : index)
            self?.updateMessage(name: model.name)
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
        let carouselView = CarouselView(viewModel: CarouselViewModel(items: self.viewModel.createCarouselModel(),selectedIndex: viewModel.selectedIndex)) { [weak self] selectedIndex in
            self?.updateDropdownView(index: selectedIndex)
            if let vm = self?.viewModel,selectedIndex < vm.dogBreed.count{
                self?.updateMessage(name: vm.dogBreed[selectedIndex].name)
            }
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
    
    private func updateMessage(name : String){
        self.messageLbl.text = "Hi, I am \(name.capitalized)"
    }
    
}
