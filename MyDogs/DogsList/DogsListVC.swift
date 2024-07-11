//
//  DogsListVC.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import UIKit

final class DogsListVC : UIViewController{
    
    @IBOutlet weak var dogsTableView: UITableView!
    var viewModel = DogsListViewModel()
    private static let cellNibName = "ListTblCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Find your favie breeds"
        self.initialSetup()
    }
    
    private func initialSetup(){
        self.registerCells()
        self.dogsTableView.dataSource = self
        self.dogsTableView.delegate = self
        self.fetchDogs()
    }
    
    private func registerCells(){
        self.dogsTableView.register(UINib(nibName: BreedTblCell.nibName, bundle: nil), forCellReuseIdentifier: BreedTblCell.nibName)
    }
    
    private func fetchDogs(){
        self.viewModel.fetchDogs { [weak self] in
            DispatchQueue.main.async {
                self?.dogsTableView.reloadData()
                self?.fetchDogImages()
            }
        }
        
            }
    
    private func fetchDogImages(){
        for (index,dog) in viewModel.dogs.enumerated() {
            self.viewModel.fetchSpecificDog(name: dog.name) { [weak self] imageURL, error in
                if let _imageURL = imageURL{
                    self?.viewModel.dogs[index].imageURL = _imageURL
                    DispatchQueue.main.async{
                        self?.dogsTableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
                    }
                }
            }
        }
    }
    
    
}

extension DogsListVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let breedCell = tableView.dequeueReusableCell(withIdentifier: BreedTblCell.nibName, for: indexPath) as? BreedTblCell{
            breedCell.config(model: self.viewModel.dogs[indexPath.row])
            return breedCell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let breedDetailVC = DogBreedDetailVC.storyboardInstance() as? DogBreedDetailVC{
            breedDetailVC.imageURL = self.viewModel.dogs[indexPath.row].imageURL ?? ""
            self.navigationController?.pushViewController(breedDetailVC, animated: true)
        }
    }
}
