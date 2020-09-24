//
//  YXLabel.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class XWLabel: UILabel {

    func setFont(size:CGFloat,isBold:Bool?=false) {
        
        self.font = isBold! ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
    }

}
