//
//  ListTblCell.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import UIKit

class BreedTblCell: UITableViewCell {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    static let nibName = "BreedTblCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.nameLbl.text = nil
        self.profileImgView.image = nil
    }
    
    func config(model : DogBreedModel){
        self.nameLbl.text = model.name
        
        if let _imageURL = model.imageURL{
            NetworkManager.shared.getData(urlStr: _imageURL) { data, error in
                if let _data = data, let image = UIImage(data: _data){
                    DispatchQueue.main.async {
                        self.profileImgView.image = image
                    }
                }else{
                    print("Error in download image")
                }
            }
        }
    }
    
}
