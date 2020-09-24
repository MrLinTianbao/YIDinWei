//
//  UIImageView+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    //MARK: 加载网络图片
    public func setUrlImage(with urlStr:String? ,placeholder: UIImage? = UIImage.init(named: "")){
        
        self.sd_setImage(with: URL.init(string: urlStr ?? ""), placeholderImage: placeholder)
    }
}
