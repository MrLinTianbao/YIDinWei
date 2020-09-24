//
//  HomeHeadView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class HomeHeadView: XWView {
    
    fileprivate let titleLabel = XWLabel()
    let noticeBtn = XWButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setMsgRead), name: .setReadMsg, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getUnreadMsg), name: .getUnreadMsg, object: nil)
        
        self.backgroundColor = UIColor.Theme.bgColor
        
        titleLabel.text = careAbout
        titleLabel.setFont(size: 18, isBold: true)
        self.addSubview(titleLabel)
        
        noticeBtn.setImage(image: "lingdang")
        self.addSubview(noticeBtn)
        
        noticeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(noticeBtn)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(noticeBtn.snp.left).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        getUnreadMsg()
        
    }
    
    //MARK: 获取未读消息
    @objc fileprivate func getUnreadMsg() {
        
        HomePresenter.getUnreadMsg { (count) in
            self.noticeBtn.setImage(image: count == "0" ? "lingdang" : "lingdang_un")
        }
        
    }
    
    //MARK: 设置消息已读
    @objc fileprivate func setMsgRead() {
        
        noticeBtn.setImage(image: "lingdang")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
