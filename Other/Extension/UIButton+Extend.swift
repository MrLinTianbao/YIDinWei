//
//  UIButton+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /// 计时器
    ///
    /// - Parameters:
    ///   - count: 时间秒数
    ///   - enabledColor: 禁止标题颜色
    public func xw_countDown(count: Int,enabledColor:UIColor){
        // 倒计时开始,禁止点击事件
        isEnabled = false
        
        // 保存当前的标题颜色
        let defaultColor = UIColor.green
        // 设置倒计时,标题颜色
        self.setTitleColor(enabledColor, for: .normal)
        
        var remainingCount: Int = count {
            willSet {
                setTitle(resend + "(\(newValue)s)", for: .normal)
                if newValue <= 0 {
                    setTitle(resend, for: .normal)
                }
            }
        }
        
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self .setTitleColor(defaultColor, for: .normal)
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
    }
    
    //MARK: 加载网络图片
    func setUrlImage(url:String) {
        
        self.sd_setBackgroundImage(with: URL.init(string: url), for: .normal, completed: nil)
    }
}

private var ActionTag = 0
typealias ButtonBlock = (XWButton?) -> Void
extension XWButton {
    
    /// 添加闭包回调
    ///
    /// - Parameter block: 闭包
    func addAction(_ block: ButtonBlock?) {
        
        objc_setAssociatedObject(self, &ActionTag, block, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        addTarget(self, action: #selector(self.action(_:)), for: .touchUpInside)
    }
    
    func addAction(_ block: ButtonBlock?, forControlEvents controlEvents: UIControl.Event) {
        objc_setAssociatedObject(self, &ActionTag, block, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        addTarget(self, action: #selector(self.action(_:)), for: controlEvents)
    }
    
    @objc func action(_ sender: Any?) {
        let blockAction = objc_getAssociatedObject(self, &ActionTag) as? ButtonBlock
        if blockAction != nil {
            blockAction?(self)
        }
    }
    
}
