//
//  DatePathView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/7.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class DatePathView: XWView {
    
    fileprivate let arrowImage = XWImageView()
    
    fileprivate let startLabel = XWLabel()
    fileprivate let endLabel = XWLabel()
    
    fileprivate let startBtn = XWButton()
    fileprivate let endBtn = XWButton()
    
    fileprivate let lineView = XWView()
    
    fileprivate let locationBtn = XWButton()
    
    var selectBlock : ((Int)->Void)?
    var locationBlock : (()->Void)?
    
    var startText = getCurrentTime().components(separatedBy: " ").first! + " 00:00:00" {
        didSet{
            startBtn.setText(text: startText)
        }
    }
    
    var endText = getCurrentTime() {
        didSet{
            endBtn.setText(text: endText)
        }
    }

    init() {
        super.init(frame: .zero)
        
        self.setCornerRadius(10)
        
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.image = "ic_guiji_time".getImage()
        self.addSubview(arrowImage)
        
        startLabel.text = startTime
        startLabel.textColor = UIColor.Theme.font
        startLabel.setFont(size: 14)
        self.addSubview(startLabel)
        
        endLabel.text = endTime
        endLabel.textColor = UIColor.Theme.font
        endLabel.setFont(size: 14)
        self.addSubview(endLabel)
        
        startBtn.addAction { (sender) in
            self.selectBlock?(1)
        }
        startBtn.setTextColor(color: UIColor.black)
        startBtn.setFont(size: 16)
        startBtn.setText(text: getCurrentTime().components(separatedBy: " ").first! + " 00:00:00")
        self.addSubview(startBtn)
        
        endBtn.addAction { (sender) in
            self.selectBlock?(2)
        }
        endBtn.setTextColor(color: UIColor.black)
        endBtn.setFont(size: 16)
        endBtn.setText(text: getCurrentTime())
        self.addSubview(endBtn)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        self.addSubview(lineView)
        
        locationBtn.addAction { (sender) in
            self.locationBlock?()
        }
        locationBtn.setBGImage(name: "ic_guiji_query")
        self.addSubview(locationBtn)
        
        locationBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(60)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35)
            make.right.equalTo(locationBtn.snp.left).offset(-10)
            make.centerY.equalTo(locationBtn)
            make.height.equalTo(1)
        }
        
        startLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(lineView.snp.top).offset(-10)
            make.left.equalTo(lineView)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        endLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.equalTo(startLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        startBtn.snp.makeConstraints { (make) in
            make.left.equalTo(startLabel.snp.right).offset(10)
            make.centerY.equalTo(startLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        endBtn.snp.makeConstraints { (make) in
            make.left.equalTo(endLabel.snp.right).offset(10)
            make.centerY.equalTo(endLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        arrowImage.snp.makeConstraints { (make) in
            make.top.equalTo(locationBtn)
            make.bottom.equalTo(locationBtn)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(startLabel.snp.left).offset(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
