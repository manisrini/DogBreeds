//
//  DogBreedDetailViewModel.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import Foundation

class DogBreedDetailViewModel{
    var dogBreed : [DogBreedModel] = []
    var selectedIndex : Int = 0

    func createCarouselModel() -> [CarouselItem]{
        var items : [CarouselItem] = []
        for breed in dogBreed{
            let item = CarouselItem(name: breed.name, imageUrl: breed.imageURL ?? "")
            items.append(item)
        }
        return items
    }
}
