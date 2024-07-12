//
//  UITableView+ext.swift
//  MyDogs
//
//  Created by Manikandan on 12/07/24.
//

import Foundation
import UIKit

extension UITableView
{
    
    public func setEmptyMessageText(_ message: String,textColor:UIColor)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Roboto", size: 16.0)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }

}
