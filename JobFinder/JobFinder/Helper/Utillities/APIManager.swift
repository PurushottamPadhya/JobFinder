//
//  APIManager.swift
//  JobFinder
//
//  Created by Purushottam on 2/24/19.
//  Copyright © 2019 Purushottamself. All rights reserved.
//

import Foundation
import Alamofire


class AlamofireManager {
    static let session : SessionManager = {
        let config = Alamofire.SessionManager.default
        config.session.configuration.timeoutIntervalForRequest = 30.0
        return config
    }()
}


public enum withRequestType {
    case withHeader, withoutHeader, withAuthorizationText, withCustomHeader
}
public class APIManager {
    
    var dataRequest: DataRequest
    var params: [String: AnyObject]?
    
    public init (_ requestType : withRequestType, urlString: String, parameters: [String: AnyObject]? = nil, headers: [String: String] = [String:String](), method: Alamofire.HTTPMethod = .post) {
        
        self.params = parameters
        let accessToken : String?
        switch requestType {
            
        case .withAuthorizationText:
            
            let header: [String: String] = ["Authorization": "Basic Og=="]
            
            self.dataRequest = Alamofire.SessionManager.default.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: header)
            break
            
        case .withoutHeader:
            
            self.dataRequest = Alamofire.SessionManager.default.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            break
            
        case .withHeader:
            
            if let token = accessToken{
                
                let header : [String : String] = [
                    
                    "X-Requested-With" : "XMLHttpRequest",
                    "authorization" : "bearer " + token
                ]
                self.dataRequest = AlamofireManager.session.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: header)
            }else{
                
                self.dataRequest = Alamofire.SessionManager.default.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            }
            
            break
            
        case .withCustomHeader:
            break
            
        }
    }
    
    
    func handleResponse<T: AllResponse>(viewController: UIViewController,isShowProgressHud: Bool = true,isShowNoNetBanner: Bool = true,isHideProgressHud: Bool = true, isShowAlertBanner: Bool = true,progressMessage: String? = nil,beforeRequest: (() -> Void)? = nil,completionHandler: @escaping (T)-> Void, errorBlock: ((T)->Void)? = nil,failureBlock: ((String)->Void)? = nil){//,failureBlockOnNoBalance: ((String)->Void)? = nil) {
        
        if let beforeRequest = beforeRequest {
            beforeRequest()
        }
        do {
            let googleTest = try Reachability(hostname: "www.google.com")
            
            guard let result = googleTest?.isReachable, result else {
                
                failureBlock?(ErrorMessage.noInternet)
                
                if isShowNoNetBanner{
                    Helper.showToast(message: ErrorMessage.noInternet)
                }
                
                return
            }
            
        } catch {
            print(error)
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if isShowProgressHud {
            
            viewController.view.isUserInteractionEnabled = false
            showProgressHUD()//(loadingString: progressMessage)
        }
        
        self.dataRequest.s { (response: DataResponse<T>) in
            
            if isHideProgressHud{
                
                hideProgressHUD()
            }
            
            DispatchQueue.main.async {
                viewController.view.isUserInteractionEnabled = true
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            let statusCode = response.response?.statusCode ?? 0
            print("statusCode:- \(statusCode)")
            
            switch response.result {
                
            case .success(let dataX):
                
                //201 for sign up and 200 for other success response
                if statusCode == 200 || statusCode == 201{
                    
                    completionHandler(dataX)
                }else if statusCode == 401{
                    let message = dataX.errorMessage ?? "You login Access Token has been expired!!! Please relogin."
                    print(message)
                    self.presentLoginAlertViews(message)
                }
                    //                else if statusCode == 403{
                    //                    //not enough balance when purchasing!!!
                    //                    failureBlockOnNoBalance?(dataX.errorMessage ?? "Sorry, not enough balance")
                    //                }
                else{
                    
                    let message = dataX.errorMessage ?? "Server Error"
                    print(message)
                    errorBlock?(dataX)
                    if isShowAlertBanner{
                        
                        AtAndroidToastMessage.message(message)
                    }
                }
            case .failure(let error):
                print(error)
                let errorMessage = error.localizedDescription//"Server Error"
                
                if statusCode == 401{
                    let message = "You login Access Token has been expired!!! Please relogin."
                    self.presentLoginAlertViews(message)
                }
                //                else if statusCode == 403{
                //                    //not enough balance when purchasing!!!
                //                    failureBlockOnNoBalance?("Sorry, not enough balance")
                //                }
                
                failureBlock?(error.localizedDescription)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if isShowAlertBanner{
                    
                    AtAndroidToastMessage.message(errorMessage)
                }
            }
        }
        
        //delete
        self.dataRequest.responseJSON { (response) in
            
            print(response.data ?? "No data")
            print(response.timeline)
            print(response.request ?? "No request")
            print(self.params ?? "No Params")
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let val):
                print(val)
            }
        }
    }

    
}




public  enum ErrorType: Error {
    case nointernetConnection
//    case <customError>
    case unathorized
    case others
}
struct ErrorMessage {
    
    static let unableToGetData = "Unable to get data."
    static let invalidUrl = "Invalid url"
    static let serverError = "Server Error"
    
    static let error = "Error"
    static let noInternet = "The Internet connection appears to be offline."
    static let unableToMapData = "Unable To Map Data."
}
