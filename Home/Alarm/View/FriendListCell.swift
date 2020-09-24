//
//  FriendListCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class FriendListCell: XWTableViewCell {
    
    fileprivate let bgView = XWView()
    let titleLabel = XWLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgView.setCornerRadius(10)
        bgView.setShadow(offsetW: 0, offsetH: 0)
        self.contentView.addSubview(bgView)
        
        titleLabel.text = "15018010805".numberEncryption()
        titleLabel.setFont(size: 16)
        bgView.addSubview(titleLabel)
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
