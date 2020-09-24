//
//  UnlockHeadView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockHeadView: XWView {
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let backImage = XWButton()
    
    fileprivate let bgView = XWView()
    fileprivate let privilegeLabel = XWLabel()
    fileprivate let recordLabel = XWLabel()
    
    var backBlock : (()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        titleLabel.text = unlockFunction
        titleLabel.textColor = UIColor.white
        titleLabel.setFont(size: 20,isBold: true)
        self.addSubview(titleLabel)
        
        backImage.setImage(image: "white_back",color: UIColor.white)
        backImage.addAction { (sender) in
            self.backBlock?()
        }
        self.addSubview(backImage)
        
        bgView.backgroundColor = UIColor.clear
        bgView.setBGImage(name: "ic_unlock_privilege")
        self.addSubview(bgView)
        
        privilegeLabel.text = privilege
        privilegeLabel.textColor = UIColor.Theme.brown
        privilegeLabel.setFont(size: 18,isBold: true)
        bgView.addSubview(privilegeLabel)
        
        recordLabel.text = historyRecord
        recordLabel.textColor = UIColor.Theme.brown
        recordLabel.setFont(size: 14)
        bgView.addSubview(recordLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(30)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(120)
        }
        
        privilegeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(30)
            make.height.greaterThanOrEqualTo(10)
        }
        
   
        recordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(privilegeLabel.snp.bottom).offset(20)
            make.left.right.equalTo(privilegeLabel)
            make.height.greaterThanOrEqualTo(10)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
