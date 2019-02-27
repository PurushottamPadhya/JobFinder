//
//  FilterTableViewCell.swift
//  JobFinder
//
//  Created by NITV on 2/27/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var checkUncheckButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(){
        
    }

}
