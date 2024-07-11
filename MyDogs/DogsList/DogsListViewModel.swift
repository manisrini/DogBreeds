//
//  DogsListViewModel.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import Foundation

final class DogsListViewModel{
    
    var dogs : [DogBreedModel] = []
    var filteredDogs : [DogBreedModel] = []
    var isSearching : Bool = false
    var isTextEmpty : Bool = false
    
    func fetchDogs(completion : @escaping() -> Void){
        
        let url = "https://dog.ceo/api/breeds/list/all"
        NetworkManager.shared.getData(urlStr: url) { [weak self] data, error in
            guard let _data = data else{ return }
                    
            do{
                if let response = try JSONSerialization.jsonObject(with: _data, options: .fragmentsAllowed) as? [String:Any]{
                    self?.createBreedModel(response: response)
                    completion()
                }
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchSpecificDog(name : String,completion : @escaping(String?,String?) -> Void){
        
        let url = "https://dog.ceo/api/breed/\(name)/images/random"
        NetworkManager.shared.getData(urlStr: url) { data, error in
            guard let _data = data else{ return }
                    
            do{
                if let response = try JSONSerialization.jsonObject(with: _data, options: .fragmentsAllowed) as? [String:Any]{
                    if let imageURL = response["message"] as? String{
                        completion(imageURL, nil)
                    }else{
                        completion(nil,error)
                    }
                }
            }catch {
                completion(nil,error.localizedDescription)
            }
        }
    }
    
    
    func filterDogBreedsWith(_ char : String){
        if char.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            self.filteredDogs = self.dogs
            return
        }
        
        self.isSearching = true
        let filteredDogs = self.dogs.filter { model in
            return model.name.range(of: char.trimmingCharacters(in: .whitespacesAndNewlines),options: .caseInsensitive) != nil
        }
        self.filteredDogs = filteredDogs
    }
    
    private func createBreedModel(response : [String:Any]){
        if let data = response["message"] as? [String:Any]{
            self.dogs = data.map { key,value in
                return DogBreedModel(name: key)
            }
        }
    }
    
    func getDataSource() -> [DogBreedModel]{
        if isSearching{
            return self.filteredDogs
        }
        return self.dogs
    }
}
