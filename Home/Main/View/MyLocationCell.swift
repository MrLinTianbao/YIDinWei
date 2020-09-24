//
//  MyLocationCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MyLocationCell: XWTableViewCell {

    fileprivate let titleLabel = XWLabel()
    fileprivate let timeLabel = XWLabel()
    fileprivate let addressLabel = XWLabel()
    
    fileprivate let lineView = XWView()
    
    var location : String! {
        didSet{
            addressLabel.text = location
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.white
        
        titleLabel.text = mySelf
        titleLabel.setFont(size: 16, isBold: true)
        self.contentView.addSubview(titleLabel)
        
        timeLabel.text = getCurrentTime()
        timeLabel.textColor = UIColor.Theme.font
        timeLabel.setFont(size: 14)
        self.contentView.addSubview(timeLabel)
        
        addressLabel.text = "详情地址"
        addressLabel.setFont(size: 14)
        addressLabel.numberOfLines = 0
        self.contentView.addSubview(addressLabel)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        self.contentView.addSubview(lineView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-20)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(timeLabel)
            make.height.greaterThanOrEqualTo(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(timeLabel)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
