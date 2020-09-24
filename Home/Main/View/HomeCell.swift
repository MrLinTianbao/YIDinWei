//
//  HomeCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class HomeCell: XWTableViewCell {
    
    var model : HomeModel! {
        didSet{
            updateData()
        }
    }
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let nameLabel = XWLabel()
    fileprivate let timeLabel = XWLabel()
    fileprivate let addressLabel = XWLabel()
    fileprivate let lineView = XWView()
    
    let editBtn = XWButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.white
        
        nameLabel.text = "aaaaa"
        nameLabel.setFont(size: 16, isBold: true)
        self.contentView.addSubview(nameLabel)
        
        titleLabel.text = "15017324286".numberEncryption()
        titleLabel.textColor = UIColor.Theme.font
        titleLabel.setFont(size: 13)
        self.contentView.addSubview(titleLabel)
        
        timeLabel.text = "2020-08-05 18:00:00"
        timeLabel.textColor = UIColor.Theme.font
        timeLabel.setFont(size: 13)
        self.contentView.addSubview(timeLabel)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        self.contentView.addSubview(lineView)
        
        addressLabel.numberOfLines = 0
        addressLabel.text = "详情地址"
        addressLabel.setFont(size: 13)
        self.contentView.addSubview(addressLabel)
        
        editBtn.setText(text: edit)
        editBtn.setFont(size: 12)
        editBtn.setTextColor(color: UIColor.Theme.pink)
        editBtn.setCornerRadius(17)
        editBtn.setborder(size: 1, color: UIColor.Theme.pink)
        self.contentView.addSubview(editBtn)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.bottom.equalTo(nameLabel)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(34)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.right.equalTo(editBtn.snp.left).offset(-20)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.right.equalTo(editBtn)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateData() {
        
        nameLabel.text = model.nickName == "" ? notName : model.nickName
        titleLabel.text = model.phone?.numberEncryption()
        timeLabel.text = model.time
        addressLabel.text = model.address
        
    }
    
}
