//
//  JobListingTableViewCell.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import UIKit


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
    
    func setJobData(_ detail: JobDetail?){
        logoImageView.image = UIImage.init(named: detail?.logo ?? "")
        jobTitleLabel.text = detail?.jobTitle ?? ""
         companyNameLabel.text = detail?.companyName ?? ""
         jobLocationLabel.text = detail?.jobLocation ?? ""
         jobPostedDateLabel.text = detail?.jobPostedDate ?? ""
    }

}
