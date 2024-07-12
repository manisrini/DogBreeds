//
//  DogsListVC.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import UIKit

final class DogsListVC : UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dogsTableView: UITableView!
    
    var viewModel = DogsListViewModel()
    private static let cellNibName = "ListTblCell"
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your fav breeds"
        self.setupNavBar()
        self.initialSetup()
        self.addRefreshController()
    }
    
    private func setupNavBar(){
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Utils.shared.hexStringToUIColor(hex: "384A62")]
    }
        
    func addRefreshController()
    {
        self.dogsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    
    @objc func pullToRefresh()
    {
        self.fetchDogs()
        refreshControl.endRefreshing()
    }

    private func initialSetup(){
        self.registerCells()
        self.searchBar.delegate = self
        self.searchBar.searchTextField.clearButtonMode = .never
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
        if viewModel.getDataSource().count == 0{
            self.dogsTableView.setEmptyMessageText("No Data Found !!!", textColor: Utils.shared.hexStringToUIColor(hex: "2F4058"))
        }else{
            self.dogsTableView.setEmptyMessageText("", textColor: .clear)
        }
        return self.viewModel.getDataSource().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let breedCell = tableView.dequeueReusableCell(withIdentifier: BreedTblCell.nibName, for: indexPath) as? BreedTblCell{
            breedCell.config(model: self.viewModel.getDataSource()[indexPath.row])
            return breedCell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let breedDetailVC = DogBreedDetailVC.storyboardInstance() as? DogBreedDetailVC{
            breedDetailVC.viewModel.dogBreed = self.viewModel.dogs
            breedDetailVC.viewModel.selectedIndex = indexPath.row
            self.navigationController?.pushViewController(breedDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.3
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DogsListVC : UISearchBarDelegate{
            
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            if !self.viewModel.isTextEmpty{
                self.viewModel.isTextEmpty = true
                self.performSearch(searchText: "")
            }
        }else{
            self.performSearch(searchText: searchText)
        }
    }
    
    private func performSearch(searchText : String){
        self.viewModel.filterDogBreedsWith(searchText)
        self.dogsTableView.reloadData()
    }
}
