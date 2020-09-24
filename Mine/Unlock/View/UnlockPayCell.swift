//
//  UnlockPayCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockPayCell: XWTableViewCell {
    
    fileprivate let logoImage = XWImageView()
    fileprivate let titleLabel = XWLabel()
    
    var isSelect = false {
        didSet{
            selectImage.image =  isSelect ? "agree_select".getImage() :  "agree_normal".getImage().xw_imageChangeColor(UIColor.Theme.lineColor)
        }
    }
    
    fileprivate let selectImage = XWImageView()
    
    var model : PayModel! {
        didSet{
            updateData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        logoImage.image = "share_wechat".getImage()
        logoImage.contentMode = .scaleAspectFit
        self.contentView.addSubview(logoImage)
        
        titleLabel.text = wechatPay
        titleLabel.setFont(size: 16)
        self.contentView.addSubview(titleLabel)
        
        selectImage.image = "agree_normal".getImage().xw_imageChangeColor(UIColor.Theme.lineColor)
        self.contentView.addSubview(selectImage)
        
        
        logoImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoImage.snp.right).offset(10)
            make.centerY.equalTo(logoImage)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        selectImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(logoImage)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateData() {
        
        switch model.mchType {
        case "wxAppPay":
            logoImage.image = "share_wechat".getImage()
            titleLabel.text = wechatPay
        case "aliAppPay":
            logoImage.image = "alipay_logo".getImage()
            titleLabel.text = aliPay
        default:
            logoImage.image = "iPhone".getImage()
            titleLabel.text = otherPay
            
        }
        
    }
}
