//
//  MBProgressHUD_XY.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import MBProgressHUD

class MBProgressHUD_XW: MBProgressHUD {

    public static func showMessage(message: String, toView: UIView?) {
            DispatchQueue.main.async {
                var currentView = toView
                if toView == nil {
                    currentView = UIApplication.shared.keyWindow
                }
                
                let hud = MBProgressHUD.showAdded(to: currentView!, animated: true)
                hud.label.text = message
                hud.label.textColor = UIColor(white: 1, alpha: 0.7)
                hud.bezelView.color = .black
    //            hud.bezelView.style = .solidColor
    //            hud.activityIndicatorColor = UIColor(netHex: 0x9B9B9B)
                hud.removeFromSuperViewOnHide = true
            }
        }
        
        public static func show(text: String, view: UIView?, _ time: TimeInterval = 1.5) {
            DispatchQueue.main.async {
                var currentView = view
                if view == nil {
                    currentView = UIApplication.shared.keyWindow
                }
                let hud = MBProgressHUD.showAdded(to: currentView!, animated: true)
                hud.label.text = text
                hud.bezelView.color = .black
                hud.bezelView.style = .solidColor
                hud.mode = .customView
                hud.removeFromSuperViewOnHide = true
                hud.label.textColor = UIColor(white: 1, alpha: 0.7)
                hud.hide(animated: true, afterDelay: time)
            }
        }
        
        public static func hide(forView: UIView?, animated: Bool) {
            DispatchQueue.main.async {
                var currentView = forView
                if currentView == nil {
                    currentView = UIApplication.shared.keyWindow
                }
                MBProgressHUD.hide(for: currentView!, animated: animated)
            }
        }

}
