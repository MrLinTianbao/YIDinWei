//
//  UnlockPresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/19.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import SwiftyJSON

class UnlockPresenter: NSObject {

    //MARK: 获取支付列表
    static func getPayList(success :(([UnlockModel],[PayModel]) -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_payList, parameters: nil, success: { (value, json) in
            
            var dataArray = [UnlockModel]()
            var list = [PayModel]()
            
            if let array = json["data"]["productList"].arrayObject as? [[String:Any]],let arr = json["data"]["thirdPayList"].arrayObject as? [[String:Any]] {
                
                for item in array {
                    let model = UnlockModel.setModel(with: item)
                    dataArray.append(model)
                }
                
                for item in arr {
                    let model = PayModel.setModel(with: item)
                    list.append(model)
                }
                
            }
            
            success?(dataArray,list)
            
        }) {
            
            
            
        }
        
    }
    
    //MARK: 内购支付
    static func purchasingRecharge(model:UnlockModel,thirdPayId:String) {
        
        AlertClass.show(isBuying)
        
        SwiftyStoreKit.purchaseProduct(model.appleProId!, atomically: false) {result in
            AlertClass.stop()
            switch result {
            case .success(let product):
                // fetch content from your server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                MyLog(product.transaction.transactionIdentifier)
                MyLog("Purchase Success: \(product.productId)")
                
                if let receiptURL = Bundle.main.appStoreReceiptURL , let receiptData = try? Data.init(contentsOf: receiptURL) {
                    let receiptStr = receiptData.base64EncodedString()
                    
                    self.checkReceipt(model.price!, receiptStr: receiptStr, transId: product.transaction.transactionIdentifier ?? "" ,priceVlaue: String(product.product.price.int32Value),cashFeeType: product.product.priceLocale.currencyCode,model:model, thirdPayId: thirdPayId)
                }
                
            case .error(let error):
                MyLog(error.errorUserInfo)
                if let errorDes = error.errorUserInfo["NSLocalizedDescription"] as? String{
                    AlertClass.showToat(withStatus: errorDes)
                }
                switch error.code {
                case .unknown: MyLog("Unknown error. Please contact support")
                case .clientInvalid: MyLog("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: MyLog("The purchase identifier was invalid")
                case .paymentNotAllowed: MyLog("The device is not allowed to make the payment")
                case .storeProductNotAvailable: MyLog("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: MyLog("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: MyLog("Could not connect to the network")
                case .cloudServiceRevoked: MyLog("User has revoked permission to use this cloud service")
                case .privacyAcknowledgementRequired:
                    MyLog("The user needs to acknowledge Apple's privacy")
                case .unauthorizedRequestData:
                    MyLog("The app is attempting to use SKPayment's requestData property, but does not have the appropriate entitlement")
                case .invalidOfferIdentifier:
                    MyLog("The specified subscription offer identifier is not valid")
                case .invalidSignature:
                    MyLog("The cryptographic signature provided is not valid")
                case .missingOfferParams:
                    MyLog("One or more parameters from SKPaymentDiscount is missing")
                case .invalidOfferPrice:
                    MyLog("The price of the selected offer is not valid (e.g. lower than the current base subscription price")
                @unknown default:
                    MyLog("unknown")
                }
            }
        }
    }
    
    //MARK: 内购支付
    fileprivate static func checkReceipt( _ IAP_Gold:String,receiptStr:String,transId:String ,priceVlaue:String,cashFeeType:String?,model:UnlockModel,thirdPayId:String) {
        
        
        
        AlertClass.show(isPaying)

        NetworkRequest.requestMethod(.post, URLString: url_pay, parameters: ["thirdPayId":thirdPayId,"productId":model.id!,"appId":appId,"linkId":linkId,"appRId":appRId,"pushId":pushId], success: { (value, json) in

            AlertClass.stop()
            
            if let orderNo = json["data"]["payData"]["orderNo"].string {

                self.validationAction(receiptStr: receiptStr, orderNo: orderNo, model: model, thirdPayId: thirdPayId)
            }

        }) {


            AlertClass.stop()
        }

        
       
    }
    
    //MARK: 内购验证
    fileprivate static func validationAction(receiptStr:String,orderNo:String,model:UnlockModel,thirdPayId:String) {
        
        AlertClass.show(beValidated)
        
        NetworkRequest.requestMethod(.post, URLString: url_applePayCb, parameters: ["orderNo":orderNo,"paymentResponse":receiptStr,"thirdPayId":thirdPayId], success: { (value, json) in
            
            SignInPresenter.getUserNews(success: { (json) in
                NotificationCenter.default.post(name: .updateUserNew, object: nil)
            }) {
                
            }

            AlertClass.stop()            

        }) {


            AlertClass.stop()
        }
        
    }
    
    //MARK: wc支付
    static func wechatPayAction(model:UnlockModel,thirdPayId:String,success :((String) -> Void)?) {
        
        AlertClass.show(isPaying)
        
        NetworkRequest.requestMethod(.post, URLString: url_pay, parameters: ["thirdPayId":thirdPayId,"productId":model.id!,"appId":appId,"linkId":linkId,"pushId":pushId], success: { (value, json) in
            
            AlertClass.stop()
            
            if let dic = json["data"].dictionaryObject {
                
                let weChatModel = WeChatPayModel.setModel(with: dic)
                
                
                let url = URL.init(string: weChatModel.payReportUrl!)
                if UIApplication.shared.canOpenURL(url!) {
                                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url!, options: [:]) { (result) in
                            
                            AlertClass.showToat(withStatus: successPay)
                            success?(weChatModel.orderId ?? "")
                            
                        }
                    } else {
                        UIApplication.shared.openURL(url!)
                    }
                    
                }else{
                    
                    AlertClass.setAlertView(msg: notWeChat, target: UIApplication.shared.keyWindow?.rootViewController, haveCancel: false, handler: nil)
                    
                }
                
                
            }
            
        }) {
            
            AlertClass.stop()
            
        }
        
        
    }
    
    //MARK: 检查支付状态
    static func checkPayStatus(orderId:String) {
        
        
        NetworkRequest.requestMethod(.post, URLString: url_wechatPayStatus, parameters: ["orderId":orderId], success: { (value, json) in
                
                if json["data"].stringValue == "success" {
                                
                    SignInPresenter.getUserNews(success: { (json) in
                        NotificationCenter.default.post(name: .updateUserNew, object: nil)
                    }) {
                        
                    }
                    
                }else{
                    NotificationCenter.default.post(name: .checkPayStatus, object: nil, userInfo: ["orderId":orderId])
                }
  
            }) {
                
                NotificationCenter.default.post(name: .checkPayStatus, object: nil, userInfo: ["orderId":orderId])

                
            }
        
    }
    
    //MARK: 设置字体样式
    static func setFontStyle() -> NSAttributedString {
        
        let string = agreePaymentAgreement.xw_changeLineForString(lineSpace: 5)
        
        let str = NSMutableAttributedString.init(attributedString: string)
        let range = (agreePaymentAgreement as NSString).range(of: paymentAgreement)
        
        //添加超链接
        str.addAttribute(NSAttributedString.Key.link, value: "privacy://", range: range)
        
        return str
        
    }
    
}
