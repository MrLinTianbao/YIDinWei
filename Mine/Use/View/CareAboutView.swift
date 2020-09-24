//
//  CareAboutView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class CareAboutView: XWView {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let imageView = XWImageView()

    init(imageStr:String) {
        super.init(frame: .zero)
        
        let image = imageStr.getImage()
        let imageH = ScreenW*image.size.height/image.size.width
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        self.addSubview(scrollView)
        
        imageView.image = image
        scrollView.addSubview(imageView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(self)
            make.height.equalTo(imageH)
        }
        
        self.layoutIfNeeded()
        
        scrollView.contentSize = .init(width: ScreenW, height: imageH)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
