//
//  NotDataView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/9/3.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class NotDataView: XWView {

    fileprivate let imageView = XWImageView()
//    fileprivate let textLabel = XWLabel()
    
    init() {
        super.init(frame: .zero)
        
        imageView.image = "ic_no_msg".getImage()
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
//        textLabel.text = notData
//        textLabel.setFont(size: 16)
//        textLabel.textColor = UIColor.gray
//        self.addSubview(textLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(ScreenW/2)
            make.height.equalTo(ScreenW/2*1.73)
        }
        
//        textLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(imageView.snp.bottom)
//            make.centerX.equalTo(imageView)
//            make.height.greaterThanOrEqualTo(10)
//            make.width.greaterThanOrEqualTo(10)
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
