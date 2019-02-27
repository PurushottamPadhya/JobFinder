//
//  FilterModel.swift
//  JobFinder
//
//  Created by NITV on 2/27/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import Foundation
import ObjectMapper

class YourFilterModel: StaticMappable  {
    var name: String?
    var isSelected = false
    
    init(_name: String?, _isSelected: Bool?) {
        name = _name
        isSelected = _isSelected ?? false
    }
    
    required init?(map: Map) {
    }
    static func objectForMapping(map: Map) -> BaseMappable? {
        return self.init(map : map)
    }
    
    func mapping(map: Map) {
        
    }
    
}
