//
//  ServiceView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class ServiceView: XWView {
    
    fileprivate let logoImage = XWImageView()
    fileprivate let qqLabel = XWLabel()
    fileprivate let timeLabel = XWLabel()

    init() {
        super.init(frame: .zero)
        
        logoImage.image = "icon".getImage()
        logoImage.contentMode = .scaleAspectFit
        self.addSubview(logoImage)
        
        qqLabel.text = serviceQQ + "：" + "3409884626"
        qqLabel.setFont(size: 16)
        self.addSubview(qqLabel)
        
        timeLabel.text = serviceTime + "：" + "9:00～18:00"
        timeLabel.setFont(size: 16)
        self.addSubview(timeLabel)
        
        logoImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        qqLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.centerX.equalTo(logoImage)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(qqLabel.snp.bottom).offset(20)
            make.centerX.equalTo(qqLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
