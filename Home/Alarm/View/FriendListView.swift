//
//  FriendListView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class FriendListView: XWButton {
    
    fileprivate let logoImage = XWImageView()
    fileprivate let lineView = XWView()
    fileprivate let textLabel = XWLabel()
    let arrowImage = XWImageView()

    override init() {
        super.init()
        
        logoImage.image = "ic_friend_list".getImage()
        self.addSubview(logoImage)
        
        textLabel.text = selectForFriendList
        textLabel.setFont(size: 16)
        self.addSubview(textLabel)
        
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.image = "tanshu_right_arrow".getImage()
        self.addSubview(arrowImage)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        self.addSubview(lineView)
        
        logoImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
        }
        
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(logoImage)
            make.width.height.equalTo(15)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(arrowImage)
            make.left.equalTo(logoImage.snp.right).offset(10)
            make.right.equalTo(arrowImage.snp.left).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
