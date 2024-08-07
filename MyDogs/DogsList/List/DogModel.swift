//
//  DogModel.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import Foundation
import UIKit


struct DogBreedModel : Hashable{
    var name : String
    var imageURL : String?
    
    init(name: String, imageURL: String? = nil) {
        self.name = name
        self.imageURL = imageURL
    }
}
