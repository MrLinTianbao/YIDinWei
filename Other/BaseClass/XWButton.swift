//
//  YXButton.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class XWButton: UIButton {
    
    var text : String {
        return (titleLabel?.text)!
    }

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.clear
        
    }
    
    func setFont(size:CGFloat,isBold:Bool?=false) {
        
        self.titleLabel?.font = isBold! ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
    }
    
    func setText(text:String) {
        
        self.setTitle(text, for: .normal)
    }
    
    func setTextColor(color:UIColor) {
        
        self.setTitleColor(color, for: .normal)
    }
    
    func setImage(image:String,color:UIColor?=nil) {
        
        if color == nil {
            self.setImage(image.getImage(), for: .normal)
        }else{
            self.setImage(image.getImage().xw_imageChangeColor(color!), for: .normal)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
