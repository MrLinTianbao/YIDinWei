//
//  UnlockHeadView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockHeadView: XWView {
    
    fileprivate let bgView = XWView()
    fileprivate let privilegeImage = XWImageView()
    fileprivate let recordLabel = XWLabel()
    fileprivate let aboutLabel = XWLabel()
    fileprivate let logoImage = XWImageView()
    fileprivate let crownImage = XWImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear

        bgView.backgroundColor = UIColor.Theme.vip_bg
        self.addSubview(bgView)
        
        crownImage.image = "crown".getImage()
        bgView.addSubview(crownImage)
        
        privilegeImage.image = "privilege".getImage()
        bgView.addSubview(privilegeImage)
        
        recordLabel.text = historyRecord
        recordLabel.textColor = UIColor.Theme.brown
        recordLabel.setFont(size: 18)
        bgView.addSubview(recordLabel)
        
        aboutLabel.text = aboutPrivilege
        aboutLabel.setFont(size: 14)
        aboutLabel.textColor = UIColor.setRGB(0x736142)
        aboutLabel.numberOfLines = 0
        bgView.addSubview(aboutLabel)
        
        logoImage.image = "diamond".getImage()
        bgView.addSubview(logoImage)
        
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.height.equalToSuperview()
        }
        
        privilegeImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(145)
            make.top.equalToSuperview().offset(25)
            make.height.equalTo(45)
        }
        
        logoImage.snp.makeConstraints { (make) in
            make.left.equalTo(privilegeImage.snp.right).offset(10)
            make.centerY.equalTo(privilegeImage)
            make.width.height.equalTo(45)
        }
        
        crownImage.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage)
            make.right.bottom.equalToSuperview()
            make.width.equalTo(90)
        }
   
        recordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.left.equalTo(privilegeImage)
            make.right.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(recordLabel.snp.bottom).offset(10)
            make.left.right.equalTo(recordLabel)
            make.height.greaterThanOrEqualTo(10)
        }
        
        self.layoutIfNeeded()
        bgView.setCorner(cornerRadius: 12, corner: [.topLeft,.topRight])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
