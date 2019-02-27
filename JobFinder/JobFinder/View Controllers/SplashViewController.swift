//
//  SplashViewController.swift
//  JobFinder
//
//  Created by Purushottam on 2/26/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        let when = DispatchTime.now() + 2 //change  2 to on your choice in sec
        DispatchQueue.main.asyncAfter(deadline: when ){
            let  vc  = self.storyboard?.instantiateViewController(withIdentifier: "JobListingVC")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
       
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
