//
//  JobListingTableViewCell.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import UIKit
import SDWebImage

class JobListingTableViewCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobLocationLabel: UILabel!
    @IBOutlet weak var jobPostedDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setJobData(_ detail: JobModel?){
        logoImageView.setImageWithUrl(url: detail?.logo ?? "", imgView: logoImageView, placeholderType: PlaceHolerType.small.rawValue)
        jobTitleLabel.text = detail?.position_title
         companyNameLabel.text = detail?.organization_name
        jobLocationLabel.text = detail?.locations?[0]
         jobPostedDateLabel.text = detail?.start_date
    }

}
