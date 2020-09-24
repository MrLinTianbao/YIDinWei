//
//  UIViewController+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: 设置错误提示框
    public func showErrorAlert(title :String? = "网络请求失败",msg:String? = "") {
        var errorStr = title
        if msg != "" {
            errorStr = global_requestFailed
        }
        
        AlertClass.showToat(withStatus: errorStr)

    }
    
    //MARK: 判断页面是否存在
    public func isCurrentViewControllerVisible(viewcontroller:UIViewController) -> Bool {
        return viewcontroller.isViewLoaded && (viewcontroller.view.window != nil)
    }
    
    
}
