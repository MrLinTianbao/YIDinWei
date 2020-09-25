//
//  NetworkRequest.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import AFNetworking

class NetworkRequest: NSObject {

    internal static var manager : AFHTTPSessionManager {
            
        ///设置网络请求超时时间
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        
        let manager = AFHTTPSessionManager.init(sessionConfiguration: configuration)
    
    
        
        //数据格式
        manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: ["text/html","application/json","text/json","text/javascript"]) as? Set<String>
        
        
        manager.requestSerializer.setValue(UserInfo.authtoken, forHTTPHeaderField: "authtoken")
        

        return manager
    }
        
        
        
        
        // MARK: - 网络请求
        /// 网络请求
        ///
        /// - Parameters:
        ///   - method: 请求方式
        ///   - URLString: url
        ///   - parameters: 参数
        ///   - success: 请求成功回调
        ///   - failure: 请求失败回调
        ///   - isEncryption: 是否加密
    static func requestMethod(_ method:RequestMethod, URLString:String , parameters : [String:Any]?,isEncryption:Bool?=true,progress:((Progress) -> Swift.Void)? = nil,constructingBodyWith block: ((AFMultipartFormData) -> Swift.Void)? = nil, success :(([String:Any] , JSON) -> Void)? ,failure:(() -> Void)? ) {
            
        var dic = parameters ?? [String:Any]()
            
        if isEncryption!{
            dic["appId"] = appId
        }
            
            MyLog(manager.requestSerializer.httpRequestHeaders)
            MyLog(dic)
            
            requestMethod(method,URLString:URLString, parameters: dic,progress:progress,constructingBodyWith:block ,success: { (response, responseObject) in
                MyLog(response)
                MyLog(responseObject)
                
                if let value = responseObject as? [String:Any] {
                    MyLog(value)
                    let json = JSON.init(value)
                    
                    if isEncryption! {
                        if json["success"].boolValue == true {
                            
                            if let data = json["data"].string {
                                
                                let jsonString = decryptionAction(data: data)
                                
                                let jsonData = jsonString.data(using: .utf8)
                                let json2 = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers)
                                
                                if json2 != nil {
                                    
                                    let dict = JSON.init(json2!)
                                    MyLog(json2)
                                    success?(value,dict)
                                }
                                
                                
                            }
                        
                        }else{
                            
                            if json["msg"].stringValue != "" {
                                AlertClass.showToat(withStatus: json["msg"].stringValue)
                            }
                            
                        }
                    }else{
                        success?(value,json)
                    }
                    
                    
                    
                    
                }else {
                    failure?()
                }
                
                
            }) { (task, error) in
                
                AlertClass.stop()
                
                MyLog(task?.response)
                MyLog("网络请求失败")
                let aError = error as NSError
                MyLog("Error : \(aError)")
                failure?()
                
                switch aError.code {
                case -1009 :
                    currentViewController()?.showErrorAlert(title: global_networkError)
                case -1001 :
                    currentViewController()?.showErrorAlert(title: global_networkTimedOut)
                default:
                    currentViewController()?.showErrorAlert(msg:aError.localizedDescription)
                    break
                }
            }
            
        }
        
        
        // MARK: 网络请求(私有方法)
        fileprivate static func requestMethod(_ method:RequestMethod, URLString:String , parameters : [String:Any]? ,progress:((Progress) -> Swift.Void)?,constructingBodyWith block: ((AFMultipartFormData) -> Swift.Void)?, success :((URLResponse?, Any?) -> Void)? ,failure:((URLSessionDataTask?,Error) -> Void)? ) {
            
            switch method {
            case .post:
                manager.post(URLString, parameters: parameters, headers: nil, progress: progress, success: { (task, responseObject) in
                    success?(task.response,responseObject)
                }, failure: { (task, aError) in
                    failure?(task,aError)
                })
            case .get:
                manager.get(URLString, parameters: parameters, headers: nil, progress: progress, success: { (task, responseObject) in
                    success?(task.response,responseObject)
                }, failure: { (task, aError) in
                    
                    //                let string = NSString.init(data: ((aError as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]) as! Data, encoding: String.Encoding.utf8.rawValue)
                    failure?(task,aError)
                })
                
            case .upload:

                let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: URLString, parameters: parameters, constructingBodyWith: block, error: nil)
//                request.setValue(CacheClass.stringForEnumKey(.authtoken) ?? "", forHTTPHeaderField: "authtoken")
                let uploadTask = self.manager.uploadTask(withStreamedRequest: request as URLRequest, progress: {
                    (uploadProgress) in
                    progress?(uploadProgress)
                }) { (response, object, error) in
                    
                    if object != nil {
                        success?(response,object)
                    }
                    if error != nil {
                        failure?(nil,error!)
                    }
                    
                }
                uploadTask.resume()
            }
            
        }
        
        //MARK: - 获取当前屏幕顶层显示控制器
        /// 获取当前屏幕顶层显示控制器
        ///
        /// - Returns: viewController
        static func currentViewController() -> UIViewController?{
            let keyWindow = UIApplication.shared.keyWindow
            var currentVc = keyWindow?.rootViewController
            if currentVc?.presentedViewController != nil {
                currentVc = currentVc?.presentedViewController
            }
            if let vc = currentVc as? UINavigationController {
                currentVc = vc.visibleViewController
            }else if let vc = currentVc as? UITabBarController {
                currentVc = vc.selectedViewController
            }
            
            return currentVc
        }
}
