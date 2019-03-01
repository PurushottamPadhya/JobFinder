//
//  FilterViewController.swift
//  JobFinder
//
//  Created by Purushottam on 2/27/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import UIKit
import AVFoundation

class FilterViewController: UIViewController {

    var filterDictionary =  Dictionary<String, Any>()
    
    fileprivate var filterDataModel : FilterModel? {
        didSet{
            if filterTableView != nil {
                filterTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var filterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setFilterDataModel()
    }
    
    
    func setFilterDataModel(){
        
        // provider object
        let govProvider = FilterDetailModel.init(_name: "govProvider", _isSelected: true)
        let githubProvider = FilterDetailModel.init(_name: "githubProvider", _isSelected: false)
        var provider = [FilterDetailModel]()
        provider.append(govProvider)
        provider.append(githubProvider)
        
        
        //location objects
        var location = [FilterDetailModel]()

        location.append(FilterDetailModel.init(_name: "USA", _isSelected: false))
        // position objects
        
        var position = [FilterDetailModel]()
        
        position.append(FilterDetailModel.init(_name: "nursing", _isSelected: false))
        
        //  filter objects
        let filterJson = NSMutableDictionary ()
        filterJson.setValue( provider, forKey: "provider")
        filterJson.setValue( provider, forKey: "location")
        filterJson.setValue( provider, forKey: "position")
        
        let filterDataMOdel = FilterModel.init(_provider: provider, _location: location, _position: position)
        
        print(filterDataMOdel)
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

extension FilterViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCellIdentifier", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "filterHeaderCellIdentifier") as? FilterHeaderTableViewCell
        if let filterData = filterDataModel {
            if let currentHeader = filterData.p
        }
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    
}
