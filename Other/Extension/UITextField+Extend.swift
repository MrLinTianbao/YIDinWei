//
//  UITextField+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    //MARK: 修改边距
    convenience init(Width:CGFloat) {
        self.init()
        
        //设置左边距
        self.leftView = UIView.init(frame: .init(x: 0, y: 0, width: Width, height: 0))
        
        //设置右边距
        self.rightView = UIView.init(frame: .init(x: 0, y: 0, width: Width, height: 0))
        //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
        
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}
