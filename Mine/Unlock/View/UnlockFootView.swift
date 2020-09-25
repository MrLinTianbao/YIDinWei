//
//  UnlockFootView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockFootView: XWView {
    
    fileprivate let unlockBtn = XWButton()
    fileprivate let selectImage = XWButton()
    fileprivate let agreeLabel = XWButton()
    fileprivate let aboutLabel = XWLabel()
    
    var isSelect = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        
        selectImage.setBGImage(name: "agree_select")
        selectImage.addAction { (sender) in
            self.selectAction()
        }
        self.addSubview(selectImage)
        
        
        agreeLabel.setTextColor(color: UIColor.black)
        agreeLabel.setText(text: agreePaymentAgreement)
        agreeLabel.setFont(size: 14)
        agreeLabel.addAction { (sender) in
            self.selectAction()
        }
        self.addSubview(agreeLabel)
        
        aboutLabel.numberOfLines = 0
        aboutLabel.attributedText = aboutAgreement.xw_changeLineForString(lineSpace: 5)
        aboutLabel.setFont(size: 14)
        self.addSubview(aboutLabel)
        
        selectImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }
        
        agreeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(selectImage.snp.right).offset(10)
            make.width.greaterThanOrEqualTo(10)
            make.centerY.equalTo(selectImage)
            make.height.greaterThanOrEqualTo(10)
        }
        
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(selectImage.snp.bottom).offset(10)
            make.left.equalTo(selectImage).offset(15)
            make.height.greaterThanOrEqualTo(10)
            make.right.equalToSuperview().offset(-20)
        }
        
    }
    
    @objc fileprivate func selectAction() {
        
        self.isSelect = !self.isSelect
        
        if self.isSelect {
            self.selectImage.setBGImage(name: "agree_select")
        }else{
            self.selectImage.setBGImage(name: "agree_normal")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
