//
//  ShareButton.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/13.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class ShareButton: XWButton {
    
    fileprivate let logoImage = XWImageView()
    fileprivate let textLabel = XWLabel()

    init(image:String,text:String) {
        super.init()
        
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = image.getImage()
        self.addSubview(logoImage)
        
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.setFont(size: 14)
        self.addSubview(textLabel)
        
        logoImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
