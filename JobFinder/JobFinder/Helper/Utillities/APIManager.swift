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
    
    func handleResponseForResponseJSON(viewController: UIViewController, loadingOnView view: UIView,withLoadingColor actColor: UIColor = .white,isShowProgressHud: Bool = true,isShowNoNetBanner: Bool = true, isShowAlertBanner: Bool = true,completionHandler: @escaping (Any)-> Void, errorBlock: ((String)->Void)? = nil,failureBlock: ((String)->Void)? = nil){
        
        do {
            let googleTest = try Reachability(hostname: "www.google.com")
            
            guard let result = googleTest?.isReachable, result else {
                
                failureBlock?(ErrorMessage.noInternet)
                
                if isShowNoNetBanner{
                    Helper.showToastShort(message:  ErrorMessage.noInternet, view: viewController.view)
                }
                return
            }
            
        } catch {
            print(error)
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let loadingView = LoadingView()
        
        if isShowProgressHud {
            
            view.isUserInteractionEnabled = false
            view.layer.zPosition = 100
            loadingView.set(withLoadingView: view, withBackgroundColor: .loadingWhite, withLoadingIndicatorColor: .background)
            //            view.addSubview(loadingView)
        }
        
        self.dataRequest.responseJSON { (response) in
            
            if isShowProgressHud{
                
                DispatchQueue.main.async {
                    view.isUserInteractionEnabled = true
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    loadingView.removeFromSuperview()
                }
            }
            
            
            let statusCode = response.response?.statusCode ?? 0
            print("statusCode:- \(statusCode)")
            
            switch response.result{
            case .success(let value):
                    completionHandler(value)
                    return
                
            case .failure(let error):
                print(error)
                    let errorMessage = ErrorPredictor.get(errorFromAlamofire: error)
                    failureBlock?(errorMessage)
            }
        }

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


public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public  enum ErrorType: Error {
    case nointernetConnection
    //case <customError>
    case unathorized
    case others
}


struct customError: Error, Decodable {
    var message: String
}
struct ErrorMessage {
    
    static let unableToGetData = "Unable to get data."
    static let invalidUrl = "Invalid url"
    static let serverError = "Server Error"
    
    static let error = "Error"
    static let noInternet = "The Internet connection appears to be offline."
    static let unableToMapData = "Unable To Map Data."
    
    static let tokenExpired = "Your token expired"
}



class LoadingView: UIView{
    
    
    public func set(withLoadingView ldView: UIView, withBackgroundColor bg: UIColor, withLoadingIndicatorColor indColor : UIColor){
        
        let size : CGFloat = 80
        self.translatesAutoresizingMaskIntoConstraints = false
        ldView.addSubview(self)
        
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.centerXAnchor.constraint(equalTo: ldView.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: ldView.centerYAnchor).isActive = true
        
        self.backgroundColor = bg
        self.isUserInteractionEnabled = false
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let indicatorColor : UIColor = .selection//actColor == .white ? .black : .white
        
        activityIndicator.color = indicatorColor
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}


class ErrorPredictor{
    class func get( errorFromAlamofire : Error) -> String{
        
        if let error = errorFromAlamofire as? AFError {
            
            switch error {
            case .invalidURL(let url):
                let errorMessage = "Invalid URL: \(url) - \(error.localizedDescription)"
                return errorMessage
                
            case .parameterEncodingFailed(let reason):
                //                let errorMessage = "Parameter encoding failed: \(error.localizedDescription)"
                print("Failure Reason: \(reason)")
                let errorMessage = "Parameter encoding failed: \(reason)"
                return errorMessage
                
            case .multipartEncodingFailed(let reason):
                //                let errorMessage = "Multipart encoding failed: \(error.localizedDescription)"
                print("Failure Reason: \(reason)")
                let errorMessage = "Multipart encoding failed: \(reason)"
                return errorMessage
                
            case .responseValidationFailed(let reason):
                //                let errorMessage = "Response validation failed: \(error.localizedDescription)"
                print("Failure Reason: \(reason)")
                var errorMessage = "Response validation failed: \(reason)"
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    errorMessage = "Downloaded file could not be read"
                    print("Downloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    errorMessage = "Content Type Missing: \(acceptableContentTypes)"
                    print("Content Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    errorMessage = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    print("Response status code was unacceptable: \(code)")
                    errorMessage = "Response status code was unacceptable: \(code)"
                }
                return errorMessage
                
            case .responseSerializationFailed(let reason):
                //                let errorMessage = "Response serialization failed: \(error.localizedDescription)"
                print("Failure Reason: \(reason)")
                let errorMessage = "Response serialization failed: \(reason)"
                return errorMessage
            }
            
        } else if let error = errorFromAlamofire as? URLError {
            if error.code == .notConnectedToInternet{
                
                return errorFromAlamofire.localizedDescription
            }
            //URLError occurred:
            let errorMessage = "\(error.localizedDescription)"
            return errorMessage
            
        } else {
            let errorMessage = "Internal Server Error"//\(errorFromAlamofire.localizedDescription)"
            return errorMessage
        }
    }
}
