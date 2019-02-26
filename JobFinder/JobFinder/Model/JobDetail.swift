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
import ObjectMapper

/*class JobDetail: Codable {
    var id : String?
    var logo: String?
    var jobTitle: String?
    var companyName: String?
    //var jobLocations:[String]?
    var jobPostedDate: String?
    var url: String?
    
    // coding keys are in order :  gov jobs
    private enum CodingKeys : String, CodingKey{
        case id
        case logo
        case jobTitle = "position_title"
        case companyName = "organization_name"
        //case jobLocation = "locations"
        case jobPostedDate = "start_date"
        case url
    
    }
    // coding keys are in order :  gov jobs, github jobs
//    enum CodingKeys : String, CodingKey{
//        case jobTitle = "position_title"
//        case companyName = "organization_name"
//        case jobLocation = "locations"
//        case jobPostedDate = "start_date"
//        case url
//        case id
//
//    }
    
}

//struct JobLocations: Codable {
//    var location: String?
//}
*/


class JobModel: StaticMappable {
    
    static func objectForMapping(map: Map) -> BaseMappable? {
        return self.init(map : map)
    }
    var id: String?
    var logo: String?
    var position_title: String?
    var organization_name: String?
    var locations: [String]?
    var start_date: String?
    var url: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        logo <- map["logo"]
        position_title <- map["position_title"]
        organization_name <- map["organization_name"]
        locations <- map["locations"]
        start_date <- map["start_date"]
        url <- map["url"]
    }
    
}
