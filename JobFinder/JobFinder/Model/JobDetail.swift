//
//  JobDetail.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class JobDetail: Codable {
    var id : String?
    var logo: String?
    var jobTitle: String?
    var companyName: String?
    var jobLocations:[JobLocations]?
    var jobPostedDate: String?
    var url: String?
    
    // coding keys are in order :  gov jobs
    private enum CodingKeys : String, CodingKey{
        case jobTitle = "position_title"
        case companyName = "organization_name"
        case jobLocation = "locations"
        case jobPostedDate = "start_date"
    
    }
//    // coding keys are in order :  gov jobs, github jobs
//    enum CodingKeys : String, CodingKey{
//        case jobTitle = "position_title"
//        case companyName = "organization_name"
//        case jobLocation = "locations"
//        case jobPostedDate = "start_date"
//        
//    }
    
}

struct JobLocations: Codable {
    var location: String?
}
