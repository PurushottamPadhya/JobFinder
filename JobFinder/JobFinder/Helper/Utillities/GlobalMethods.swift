//
//  GlobalMethods.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import Foundation
import  UIKit

enum PlaceHolerType: String {
    case small = "small-icon"
    case medium = "medium-icon"
    case large = "large-icon"
}

func showProgressHud(){
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
}

func hideProgressHud(){
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
}

extension UIImageView{
    
    func setImageWithUrl(url: String, imgView: UIImageView, placeholderType: String){
        
        if  placeholderType == PlaceHolerType.small.rawValue {
            imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "defaultIcon"))
        }
            
        else {
            imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
