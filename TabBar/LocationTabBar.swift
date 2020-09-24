//
//  LocationTabBar.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class LocationTabBar: UITabBar {
    
    let centerBtn = XWButton() //中间按钮

    init() {
        super.init(frame: .zero)
        
        initView()
        
    }
    
    fileprivate func initView() {
        
        //设置背景，去除黑线
        self.backgroundImage = UIImage()//"tab_bg".getImage()
        self.shadowImage = UIImage()
        
        //去除选择时高亮
        centerBtn.adjustsImageWhenHighlighted = false
        
        self.addSubview(centerBtn)
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //  设定button大小为适应图片
        let normalImage = "main_location_n".getImage()
        
        let width = normalImage.size.width/3*2
        let height = normalImage.size.height/3*2
        
        centerBtn.backgroundColor = UIColor.white
        centerBtn.setImage(normalImage, for: .normal)
        
        //根据图片调整button的位置(图片中心在tabbar的中间最上部，这个时候由于按钮是有一部分超出tabbar的，所以点击无效，要进行处理)
        centerBtn.frame = .init(x: (ScreenW-width)/2, y: -20, width: width, height: height)
        centerBtn.setCornerRadius(width/2)
        
    }
    
    //MARK: 处理超出区域点击无效的问题
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if !self.isHidden{
            //转换坐标
            let tempPoint = centerBtn.convert(point, from: self)
            //判断点击的点是否在按钮区域内
            if centerBtn.bounds.contains(tempPoint) {
                // 返回按钮
                return centerBtn
            }
                
            
        }
        return super.hitTest(point, with: event)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
