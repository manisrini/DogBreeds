//
//  CarouselViewModel.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import Foundation

class CarouselViewModel : ObservableObject
{
    @Published var items : [CarouselItem] = []
    @Published var selectedIndex : Int = 0
    var url : String = ""
    
    init(items: [CarouselItem], selectedIndex: Int = 0) {
        self.items = items
        self.selectedIndex = selectedIndex
    }
    
    func fetchImage(name : String){
        
        let url = "https://dog.ceo/api/breed/\(name)/images/random"
        
        NetworkManager.shared.getData(urlStr: url) { [weak self] data, error in
            guard let _data = data else{ return }
                    
            do{
                if let response = try JSONSerialization.jsonObject(with: _data, options: .fragmentsAllowed) as? [String:Any]{
                    
                    if let imageURL = response["message"] as? String{
                        let index = self?.items.firstIndex(where: { item in
                            item.name == name
                        })
                        
                        DispatchQueue.main.async {
                            if let _index = index,_index < self?.items.count ?? 0{
                                let tempItem = CarouselItem(name:  name, imageUrl: imageURL)
                                self?.items[_index] = tempItem
                            }
                        }
                    }
                }
            }catch {
                print("Some error occurred")
            }
        }
    }
    
}
