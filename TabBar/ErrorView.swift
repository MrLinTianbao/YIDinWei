//
//  ErrorView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/9/3.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class ErrorView: XWView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = XWImageView()
        imageView.frame = .init(x: 20, y: ScreenH/4, width: ScreenW-40, height: ScreenH/2)
        imageView.image = "reqError".getImage()
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
