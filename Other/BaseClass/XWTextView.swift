//
//  YXTextView.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/6/3.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

@objc protocol XWTextViewDelegate {
    @objc optional func textDidChange(text:String) //监听输入文本
}

class XWTextView: UITextView {
    
    weak var textDelegate : XWTextViewDelegate?
    
    fileprivate let tipLabel = XWLabel()
    
    func setFont(size:CGFloat,isBold:Bool?=false) {
        
        self.font = isBold! ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
    }
    
    var placeholder = "" {
        didSet{
            tipLabel.text = placeholder
        }
    }
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        
        self.delegate = self
        
        tipLabel.numberOfLines = 0
        tipLabel.preferredMaxLayoutWidth = ScreenW-20
        tipLabel.textColor = UIColor.gray
        tipLabel.setFont(size: 14)
        self.addSubview(tipLabel)
        
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.greaterThanOrEqualTo(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension XWTextView : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        tipLabel.isHidden = textView.text != ""
        
        self.textDelegate?.textDidChange?(text: textView.text)
        
    }
}
