//
//  AddWechatView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class AddWechatView: XWButton {

    fileprivate let textLabel = XWLabel()
    let arrowImage = XWImageView()
    
    override init() {
        super.init()
        
        self.backgroundColor = UIColor.white
        
        self.setCornerRadius(10)
        self.setShadow(offsetW: 0, offsetH: 0)
        
        textLabel.text = selectForFriendList
        textLabel.setFont(size: 16,isBold: true)
        self.addSubview(textLabel)
        
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.image = "tanshu_right_arrow".getImage()
        self.addSubview(arrowImage)
        
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(arrowImage)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(arrowImage.snp.left).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
