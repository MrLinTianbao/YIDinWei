//
//  FriendShareView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/13.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class FriendShareView: XWView {
    
    fileprivate let bgView = XWView()
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let cancelBtn = XWButton()
    fileprivate let wechatBtn = ShareButton.init(image: "share_wechat", text: wechat)
    fileprivate let circelBtn = ShareButton.init(image: "share_wechat_moments", text: friendCircle)
    
    fileprivate let lineView = XWView()
    fileprivate let lineView2 = XWView()
    
    var shareBlock : ((Int)->Void)?

    override init(frame:CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.Theme.alpha
        
        bgView.frame = .init(x: 0, y: ScreenH, width: ScreenW, height: isIPhoneX ? 190 : 180)
        self.addSubview(bgView)
        
        titleLabel.frame = .init(x: 0, y: 0, width: ScreenW, height: 40)
        titleLabel.text = shareOf
        titleLabel.setFont(size: 16)
        titleLabel.textAlignment = .center
        bgView.addSubview(titleLabel)
        
        wechatBtn.addAction { (sender) in
            self.shareBlock?(0)
        }
        wechatBtn.frame = .init(x: ScreenW/4-30, y: 60, width: 60, height: 60)
        bgView.addSubview(wechatBtn)
        
        circelBtn.addAction { (sender) in
            self.shareBlock?(1)
        }
        circelBtn.frame = .init(x: ScreenW/4*3-30, y: 60, width: 60, height: 60)
        bgView.addSubview(circelBtn)
        
        cancelBtn.addAction { (sender) in
            
            self.removeSelectView()
            
            
        }
        cancelBtn.frame = .init(x: 0, y: 140, width: ScreenW, height: isIPhoneX ? 50 : 40)
        cancelBtn.setText(text: cancelShare)
        cancelBtn.setTextColor(color: UIColor.black)
        cancelBtn.setFont(size: 16)
        bgView.addSubview(cancelBtn)
        
        lineView.frame = .init(x: 0, y: 40, width: ScreenW, height: 1)
        lineView.backgroundColor = UIColor.Theme.lineColor
        bgView.addSubview(lineView)
        
        lineView2.frame = .init(x: 0, y: 140, width: ScreenW, height: 1)
        lineView2.backgroundColor = UIColor.Theme.lineColor
        bgView.addSubview(lineView2)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeSelectView()
    }
    
    fileprivate func removeSelectView() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.bgView.y = ScreenH
        }) { (flag) in
            self.removeFromSuperview()
        }
    }
    
    public func showDateView() {
        
        UIView.animate(withDuration: 0.2) {
            self.bgView.maxY = ScreenH
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
