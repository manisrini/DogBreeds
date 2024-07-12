//
//  ListTblCell.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import UIKit

class BreedTblCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImgView: CustomImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var redirectImgView: UIImageView!
    
    static let nibName = "BreedTblCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImgView.layer.cornerRadius = 15
        self.profileImgView.layer.borderColor = UIColor.lightGray.cgColor
        self.profileImgView.layer.borderWidth = 1
        self.containerView.layer.cornerRadius = 8
        self.nameLbl.font = UIFont(name: "Roboto-Medium", size: 16)
        self.redirectImgView.image = UIImage(named: "chevronRight")?.withRenderingMode(.alwaysTemplate)
        self.redirectImgView.tintColor = Utils.shared.hexStringToUIColor(hex: "384A62")
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
        self.nameLbl.text = model.name.capitalized
        
        if let _imageURL = model.imageURL{
            self.profileImgView.loadImage(url: _imageURL)
        }
    }
    
}
