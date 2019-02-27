//
//  JobDetailViewController.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import UIKit
import WebKit

class JobDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var activityIndicator = UIActivityIndicatorView()
    var redirectUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        
        self.setupWebview()
    }
    
    func setupWebview(){
    
        // make a request
        let request = URLRequest(url: URL(string: redirectUrl)!)
        //load requested url on the webview
        webView.load(request)
        webView.navigationDelegate = self
        self.webView.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
    }
    func showActivityIndicator(){
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
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

extension JobDetailViewController: WKNavigationDelegate {
    //start network activity indicator when the web request loading
    

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        self.showActivityIndicator()
    }
    
    // stop network activity indicator after loaded web details
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //print navigation response and response mime type
        decisionHandler(.allow)
    }
    
}
