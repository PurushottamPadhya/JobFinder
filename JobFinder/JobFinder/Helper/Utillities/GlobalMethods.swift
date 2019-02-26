//
//  GlobalMethods.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import Foundation
import  UIKit

func showProgressHud(){
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
}

func hideProgressHud(){
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
}
