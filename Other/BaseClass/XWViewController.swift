//
//  YXViewController.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class XWViewController: UIViewController {
    
    fileprivate lazy var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let backImg = UIImage.init(named: "white_back")
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //修改返回按钮图片
        self.navigationController?.navigationBar.backIndicatorImage = backImg
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImg
        
        
        //不让导航栏遮挡视图
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.backgroundColor = UIColor.white
        
        //修改返回按钮文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        
        //导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        // 设置返回文字颜色,默认返回按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        //设置中部文字属性
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
        
        getLocationStatus()
        
        if let pushOptions = CacheClass.objectForKey("pushOptions") {
            
            let json = JSON.init(pushOptions)
            getPushType(json: json)
            
            
            CacheClass.removeObjectForKey("pushOptions")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushAction(sender:)), name: .apnsPush, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .apnsPush, object: nil)
        
    }
    
    //MARK: 处理推送
    @objc fileprivate func pushAction(sender:Notification) {
        
            
        let json = JSON.init(sender.userInfo as Any)
        
        getPushType(json: json)

        
    }
    
    //MARK: 获取推送类型
    fileprivate func getPushType(json:JSON) {
        
        
    }

    //MARK: 带标题的右键
    func setNavRightItem(title: String,titleColor:UIColor = UIColor.white) {
           
           let navRightItem = UIBarButtonItem(title: title.localized(), style: .plain, target: self, action: #selector(self.actionRightItemClick))
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: titleColor], for: .normal)
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: titleColor], for: .highlighted)
           
           navigationItem.rightBarButtonItem = navRightItem
           
       }
       
       //MARK: 带图片的右键
       func setNavRightItem(imageStr: String) {
           
           let navRightItem = UIBarButtonItem.init(image: UIImage.init(named: imageStr), style: .done, target: self, action: #selector(self.actionRightItemClick))
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .highlighted)
           
           navigationItem.rightBarButtonItem = navRightItem
           
       }
       
       //MARK: 带图片的左键
       func setNavLeftItem(imageStr: String) {
           
           let navRightItem = UIBarButtonItem.init(image: UIImage.init(named: imageStr), style: .done, target: self, action: #selector(self.actionLeftItemClick))
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .highlighted)
           
           navigationItem.leftBarButtonItem = navRightItem
           
       }
       
       //MARK: 带标题的左键
       func setNavLeftItem(title: String,titleColor:UIColor = UIColor.white) {
           
           let navRightItem = UIBarButtonItem(title: title.localized(), style: .plain, target: self, action: #selector(self.actionLeftItemClick))
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: titleColor], for: .normal)
           navRightItem.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: titleColor], for: .highlighted)
           
           navigationItem.leftBarButtonItem = navRightItem
           
       }
       
       //MARK: 让视图覆盖状态栏
       func setAdjustmentBehavior(srvData:UIScrollView){
           if #available(iOS 11.0, *) {
               srvData.contentInsetAdjustmentBehavior = .never
           } else {
               automaticallyAdjustsScrollViewInsets = false
           }
       }
       
       @objc public func actionRightItemClick() {
           
           
       }
       
       @objc public func actionLeftItemClick() {
           
            
       }
    
    fileprivate func getLocationStatus() {
        
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {

            
            
        } else if CLLocationManager.authorizationStatus() == .denied {

            //定位不能用
            AlertClass.setAlertView(title: nil, msg: openLocationPermission, target: self, actionTitle: positioning, cancelTitle: notLocate, haveCancel: true) { (alert) in
                
                let url = URL(string: UIApplication.openSettingsURLString)

                if let url = url {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.openURL(url)
                    }
                }
            }


        } else if CLLocationManager.authorizationStatus() == .notDetermined {
            AlertClass.setAlertView(msg: requestLocationPermission, target: self, haveCancel: true) { (alert) in
                
                self.manager.requestWhenInUseAuthorization()
            }
        }
    }

}
