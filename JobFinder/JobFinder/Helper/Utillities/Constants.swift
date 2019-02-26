//
//  Constants.swift
//  JobFinder
//
//  Created by NITV on 2/25/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import Foundation


enum urlType : String{
    
    case local = ""
    case live = "https://my.ntentertainment.net/api/"
}

let baseUrl = urlType.live.rawValue
struct urlCollection  {
    
    static let appStoreLink = "https://itunes.apple.com/np/app/highlights-nepal/id980657024?mt=8"
    
    static let jobListUrl = ""
    static let govJobListBaseUrl = "https://jobs.search.gov/jobs/search.json"
    static let govJobList = "https://jobs.search.gov/jobs/search.json?query=nursing+jobs"
    static let govAllJobs = "?query=nursing+jobs"
    
    
    static let gitHubJobListBaseUrl =  "https://jobs.github.com/positions.json"

}

public let BASE_URL = ""


public let JOB_LIST_URL = ""


