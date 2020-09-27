//
//  UnlockFootView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockFootView: XWView {
    
    var agreementBlock : ((String)->Void)?
    
    fileprivate let unlockBtn = XWButton()
    fileprivate let selectImage = XWButton()
    fileprivate let aboutLabel = XWLabel()
    fileprivate let tipLabel = XWTextView()
    
    var isSelect = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        
        selectImage.setBGImage(name: "agree_select")
        selectImage.addAction { (sender) in
            self.selectAction()
        }
        self.addSubview(selectImage)
        
        tipLabel.attributedText = UnlockPresenter.setFontStyle()
        tipLabel.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.Theme.red]
        tipLabel.delegate = self
        tipLabel.setFont(size: 14)
        tipLabel.isEditable = false
        self.addSubview(tipLabel)
        
        aboutLabel.numberOfLines = 0
        aboutLabel.attributedText = aboutAgreement.xw_changeLineForString(lineSpace: 5)
        aboutLabel.setFont(size: 14)
        self.addSubview(aboutLabel)
        
        selectImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(selectImage.snp.right)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(13)
            make.height.equalTo(30)
        }
        
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(selectImage.snp.bottom).offset(10)
            make.left.equalTo(tipLabel)
            make.height.greaterThanOrEqualTo(10)
            make.right.equalTo(tipLabel)
        }
        
    }
    
    @objc fileprivate func selectAction() {
        
        self.isSelect = !self.isSelect
        
        if self.isSelect {
            self.selectImage.setBGImage(name: "agree_select")
        }else{
            self.selectImage.setBGImage(name: "agree_normal",color: UIColor.Theme.lineColor)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UnlockFootView : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        if URL.scheme == "privacy" {
            
            self.agreementBlock?(URL.scheme!)
            return true
            
        }
        
        return false
    }
    
}
