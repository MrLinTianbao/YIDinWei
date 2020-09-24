//
//  MineCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/6.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MineCell: XWTableViewCell {
    
    let logoImageView = XWImageView()
    
    let titleLabel = XWLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        logoImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(logoImageView)
        
        titleLabel.setFont(size: 16)
        self.contentView.addSubview(titleLabel)
        
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.centerY.equalTo(logoImageView)
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
