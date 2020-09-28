//
//  UIColor+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

extension UIColor {
    
    // MARK: 十六进制转rgb
    @objc class func setRGB(_ rgbValue:UInt) -> UIColor {
        return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
    }
    
    // MARK: rgb
    class func rgb(_ red: Int,_ green: Int,_ blue: Int, transparency: CGFloat = 1) -> UIColor{
        
        return UIColor.init(red: red, green: green, blue: blue, transparency: transparency)!
    }
    
    
}

extension UIColor {
    
    struct Theme {
        
        static let lineColor = UIColor.black.withAlphaComponent(0.1)
        
        static let alpha = UIColor.black.withAlphaComponent(0.5)
        
        static let yellow = UIColor.rgb(244, 197, 134)
        
        static let green = UIColor.rgb(16, 176, 102)
        
        static let red = UIColor.setRGB(0xf83e54)
        
        static let pink = UIColor.setRGB(0xFFA2AC)
        
        static let golden = UIColor.setRGB(0xFAD89A)
        
        static let cyan = UIColor.rgb(148, 232, 197)
        
        static let blue = UIColor.rgb(0, 198, 172)
        
        static let goldenBlack = UIColor.setRGB(0x282022)
        
        static let brown = UIColor.setRGB(0xEEC47E)
        
        static let gray = UIColor.darkGray
        
        static let bgColor = UIColor.setRGB(0xF7F3F5)
        
        static let black = UIColor.rgb(35, 35, 35)
        
        static let font = UIColor.setRGB(0x9A9A9A)
        
        static let vip_bg = UIColor.setRGB(0x282123)
        
        
        /// 根据字符串获取颜色
        ///
        /// - Parameter name: 字符串
        /// - Returns: 颜色
        static func color(with name: String) -> UIColor {
            if name.contains("#") {
                
                return UIColor.init(hexString: name) ?? UIColor.black
            }
            
            else if name.contains("rgb") {
                
                if let subStr = name.xw_stringBy(previousString: "(", laterString: ")") {
                    let arr = subStr.components(separatedBy: ",")
                    return UIColor.rgb(Int(arr[0])!, Int(arr[1])!, Int(arr[2])!)
                }else{
                    return UIColor.black
                }
                
                
            }else{
            
                switch name {
                case "lineColor":
                    return lineColor
                case "yellow":
                    return yellow
                case "green":
                    return golden
                case "golden":
                    return green
                case "cyan":
                    return cyan
                case "goldenBlack":
                    return goldenBlack
                case "brown":
                    return brown
                case "gray":
                    return gray
                case "black":
                    return black
                case "font":
                    return font
                case "alpha":
                    return alpha
                case "blue":
                    return blue
                case "red":
                    return red
                case "pink":
                    return pink
                case "vip_bg":
                    return vip_bg
                default:
                    return UIColor.black
                }
                
            }
        }
    }
}
