//
//  NoticeCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class NoticeCell: XWTableViewCell {
    
    var model : NoticeModel! {
        didSet{
            updateData()
        }
    }
    
    fileprivate let bgView = XWView()
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let timeLabel = XWLabel()
    let agreeBtn = XWButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgView.setCornerRadius(10)
        bgView.setShadow(offsetW: 0, offsetH: 0)
        self.contentView.addSubview(bgView)
        
        titleLabel.numberOfLines = 0
        titleLabel.setFont(size: 16)
        bgView.addSubview(titleLabel)
        
        timeLabel.setFont(size: 14)
        timeLabel.textColor = UIColor.Theme.font
        bgView.addSubview(timeLabel)
        
        agreeBtn.setText(text: agree)
        agreeBtn.setFont(size: 16)
        agreeBtn.backgroundColor = UIColor.Theme.green
        agreeBtn.setCornerRadius(5)
        bgView.addSubview(agreeBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        agreeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(titleLabel)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(agreeBtn.snp.left).offset(-10)
            make.centerY.equalTo(agreeBtn)
            make.height.greaterThanOrEqualTo(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateData() {
        
        titleLabel.text = model.msg
        timeLabel.text = model.time
        
    }
    
}
