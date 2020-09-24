//
//  InputPhoneView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class InputPhoneView: XWView {
    
    fileprivate let logoImage = XWImageView()
    fileprivate let lineView = XWView()
    fileprivate let phoneTF = XWTextField()
    let bookButton = XWButton()
    
    var text : String {
        
        return phoneTF.text ?? ""
    }
    
    var textStr : String! {
        didSet{
            phoneTF.text = textStr
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        logoImage.image = "add_friend_phone_icon".getImage()
        self.addSubview(logoImage)
        
        phoneTF.keyboardType = .numberPad
        phoneTF.placeholder = inputPhone
        phoneTF.setFont(size: 16)
        self.addSubview(phoneTF)
        
        bookButton.setText(text: addressBook)
        bookButton.setTextColor(color: UIColor.Theme.green)
        bookButton.setCornerRadius(12.5)
        bookButton.setFont(size: 14)
        bookButton.setborder(size: 1, color: UIColor.Theme.green)
        self.addSubview(bookButton)
        
        lineView.backgroundColor = UIColor.Theme.lineColor
        self.addSubview(lineView)
        
        logoImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
        }
        
        bookButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(logoImage)
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.centerY.equalTo(bookButton)
            make.left.equalTo(logoImage.snp.right).offset(10)
            make.right.equalTo(bookButton.snp.left).offset(-10)
            make.height.equalTo(bookButton)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
