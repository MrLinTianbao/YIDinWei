//
//  UseHeadView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UseHeadView: XWView {
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let shareBtn = XWButton()
    
    var shareBlock : (()->Void)?

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.Theme.cyan
        
        titleLabel.numberOfLines = 0
        titleLabel.text = openPosition
        titleLabel.setFont(size: 16)
        self.addSubview(titleLabel)
        
        shareBtn.setText(text: appShare)
        shareBtn.backgroundColor = UIColor.Theme.blue
        shareBtn.setFont(size: 18)
        shareBtn.addAction { (sender) in
            self.shareBlock?()
        }
        self.addSubview(shareBtn)
        
        shareBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(shareBtn)
            make.right.equalTo(shareBtn.snp.left).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
