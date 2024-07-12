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
    
    init(items: [CarouselItem], selectedIndex: Int = 0) {
        self.items = items
        self.selectedIndex = selectedIndex
    }
    
}
