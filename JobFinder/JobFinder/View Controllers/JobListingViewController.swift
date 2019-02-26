//
//  ViewController.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import UIKit

class JobListingViewController: UIViewController {
    
    @IBOutlet weak var jobTableView: UITableView!
    
    var jobDetails = [JobDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.jobTableView.reloadData()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getJobs(with: nil)
    }
    
    func getJobs(with category : String?){
        var jobsUrl = ""
        if let cat = category{
            
        }
        else{
           jobsUrl = urlCollection.govJobListBaseUrl + urlCollection.govAllJobs
        }
        jobsUrl = urlCollection.govJobListBaseUrl + urlCollection.govAllJobs
        
        APIManager.init(.withoutHeader,
                        urlString: jobsUrl,
                        method: .get).handleResponseForResponseJSON(viewController:
                            self, loadingOnView: self.view,
                                  withLoadingColor: .white,
                                  completionHandler: { [weak self](data) in
                                    
                                    guard let strongSelf = self else {return}
                                    
                                   // guard let data = data else {print("error on data"); return}

                                    do {
                                        let jobDetails = try JSONDecoder().decode([JobDetail].self, from: data as! Data)
                                        strongSelf.jobDetails = jobDetails
                                        print(jobDetails)
                                    }
                                    catch let parsingError {
                                        print("Error", parsingError)
                                    }
                                    
                            }, errorBlock: {
                                [weak self] error in
                                guard let _ = self else { return }
                                
                            }, failureBlock: {
                                [weak self] failure in
                                guard let _ = self else { return }
                        })
        
    }

}

extension JobListingViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "job", for: indexPath) as! JobListingTableViewCell
        
        cell.setJobData(jobDetails[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedJob = jobDetails[indexPath.row]
        print(selectedJob)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}

