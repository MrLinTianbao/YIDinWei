//
//  MyLocationView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/7.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MyLocationView: XWView {
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let timeLabel = XWLabel()
    fileprivate let addressLabel = XWLabel()
    fileprivate let pathBtn = XWButton()
    
    var address : String! {
        didSet{
            addressLabel.text = address
        }
    }
    
    var pathBlock : (()->Void)?

    init() {
        super.init(frame: .zero)
        
        self.setCornerRadius(10)
        
        titleLabel.text = mySelf
        titleLabel.setFont(size: 18, isBold: true)
        self.addSubview(titleLabel)
        
        timeLabel.text = getCurrentTime()
        timeLabel.textColor = UIColor.Theme.font
        timeLabel.setFont(size: 16)
        self.addSubview(timeLabel)
        
        addressLabel.numberOfLines = 0
        addressLabel.textColor = UIColor.Theme.font
        addressLabel.setFont(size: 16)
        self.addSubview(addressLabel)
        
        pathBtn.setText(text: path)
        pathBtn.setTextColor(color: UIColor.blue)
        pathBtn.setFont(size: 16)
        pathBtn.addAction { (sender) in
            self.pathBlock?()
        }
        self.addSubview(pathBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(titleLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        pathBtn.snp.makeConstraints { (make) in
            make.right.equalTo(timeLabel)
            make.width.equalTo(40)
            make.height.greaterThanOrEqualTo(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.right.equalTo(pathBtn.snp.left).offset(-10)
            make.left.equalTo(titleLabel)
            make.centerY.equalTo(pathBtn)
            make.height.greaterThanOrEqualTo(10)
        }
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
