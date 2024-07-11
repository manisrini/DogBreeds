//
//  ViewController+ext.swift
//  MyDogs
//
//  Created by Manikandan on 11/07/24.
//

import UIKit

extension UIViewController{
    
    static func storyboardInstance() -> UIViewController?{
        let instanceString = NSStringFromClass(type(of: self.init()) as AnyClass).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: instanceString, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: instanceString)
    }
}
