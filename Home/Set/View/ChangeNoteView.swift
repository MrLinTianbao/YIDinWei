//
//  ChangeNoteView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/18.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class ChangeNoteView: XWView {
    
    fileprivate let bgView = XWView()
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let cancelBtn = XWButton()
    fileprivate let noteTF = XWTextField.init(Width: 10)
    fileprivate let lineView = XWView()
    fileprivate let confirmBtn = XWButton()
    
    var changeBlock : ((String)->Void)?

    init() {
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = true
        
        self.backgroundColor = UIColor.Theme.alpha
        
        bgView.frame = .init(x: 0, y: ScreenH, width: ScreenW, height: isIPhoneX ? 180 : 160)
        self.addSubview(bgView)
        
        titleLabel.textAlignment = .center
        titleLabel.frame = .init(x: ScreenW/4, y: 20, width: ScreenW/2, height: 20)
        titleLabel.text = changeNote
        titleLabel.setFont(size: 16, isBold: true)
        bgView.addSubview(titleLabel)
        
        cancelBtn.addAction { (sender) in
            self.removeSelectView()
        }
        cancelBtn.setImage(image: "ic_close")
        bgView.addSubview(cancelBtn)
        
        noteTF.placeholder = inputNote
        noteTF.setFont(size: 16)
        bgView.addSubview(noteTF)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        bgView.addSubview(lineView)
        
        confirmBtn.addAction { (sender) in
            if self.noteTF.text == "" || self.noteTF.text!.count > 16 {
                AlertClass.showToat(withStatus: inputNote)
                return
            }
            self.changeBlock?(self.noteTF.text!)
        }
        confirmBtn.setText(text: global_confirm)
        confirmBtn.setFont(size: 16)
        confirmBtn.backgroundColor = UIColor.Theme.red
        bgView.addSubview(confirmBtn)
        
    }
    
    override func layoutSubviews() {
        
        cancelBtn.frame = .init(x: ScreenW-30, y: 20, width: 20, height: 20)
        noteTF.frame = .init(x: 0, y: 60, width: ScreenW, height: 30)
        lineView.frame = .init(x: 0, y: 100, width: ScreenW, height: 1)
        confirmBtn.frame = .init(x: 0, y: 120, width: ScreenW, height: isIPhoneX ? 60 : 40)
        
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
