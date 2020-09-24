//
//  UILabel+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

//MARK: ******************************************************** label 操作
extension UILabel {
    
    /// 多行字符串,字符串后面显示不全会自动换行
    ///
    /// - Parameter lineSpacing: 行空隙
    func xw_paragraphStyleWithLine(lineSpacing:CGFloat,wordSpacing:CGFloat = 0){
        
        let attributedString = NSMutableAttributedString.init(string: self.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing //行间距
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.kern:wordSpacing], range: NSMakeRange(0, (self.text?.count)!))
        self.attributedText = attributedString
        self.lineBreakMode = .byCharWrapping
        
    }
    
    /// 指定的字符串修改字体大小，颜色
    ///
    /// - Parameters:
    ///   - arrString: 字符串数组
    ///   - font: 字体
    ///   - color: 修改的颜色
    ///   - lineSpacing: 行间距
    func xw_paragraphStyleWithArrString(arrString:[String],font:UIFont?,color:UIColor?,lineSpacing:CGFloat = 4){
        
        let textAlignment = self.textAlignment
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString = NSMutableAttributedString.init(string: self.text!, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle])
        
        for string in arrString {
            if font != nil {
                let range = NSString.init(string: self.text!).range(of: string)
                attributedString .addAttribute(NSAttributedString.Key.font, value: font!, range: range)
            }
            
            if color != nil {
                let range = NSString.init(string: self.text!).range(of: string)
                attributedString .addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: range)
            }
        }
        
        self.attributedText = attributedString
        self.textAlignment = textAlignment
        
    }
}


