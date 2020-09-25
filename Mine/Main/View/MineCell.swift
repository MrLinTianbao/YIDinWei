//
//  MineCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/6.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MineCell: XWTableViewCell {
    
    let bgView = XWView()
    let nextImage = XWImageView()
    let titleLabel = XWLabel()
    let lineView = XWView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(bgView)
        
        titleLabel.setFont(size: 16,isBold: true)
        self.contentView.addSubview(titleLabel)
        
        nextImage.contentMode = .scaleAspectFit
        nextImage.image = "tanshu_right_arrow".getImage()
        self.contentView.addSubview(nextImage)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        self.contentView.addSubview(lineView)
        
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
        }
        
        nextImage.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-20)
            make.centerY.equalTo(bgView)
            make.width.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(20)
            make.centerY.equalTo(bgView)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(titleLabel)
            make.right.equalTo(nextImage)
            make.height.equalTo(0.5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
