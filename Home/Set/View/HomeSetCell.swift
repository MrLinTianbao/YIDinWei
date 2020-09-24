//
//  HomeSetCell.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class HomeSetCell: XWTableViewCell {
    
    let titleLabel = XWLabel()
    fileprivate let lineView = XWView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.textColor = UIColor.Theme.gray
        titleLabel.setFont(size: 16)
        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        self.contentView.addSubview(lineView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.leading.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
