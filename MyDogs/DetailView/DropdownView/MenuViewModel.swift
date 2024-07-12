//
//  MenuViewModek.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import Foundation

class MenuViewModel : ObservableObject
{
    var items : [DogBreedModel] = []
    @Published var dropdownText : String? = nil
    
    init(items: [DogBreedModel], dropdownText: String? = nil) {
        self.items = items
        self.dropdownText = dropdownText
    }

    func updateDropdownText(model : DogBreedModel){
        self.dropdownText = model.name
    }
    
    func getDropdownText() -> String{
        if let _dropdownText = dropdownText{
            return _dropdownText.capitalized
        }else{
            return items.first?.name.capitalized ?? "---"
        }
    }

}
