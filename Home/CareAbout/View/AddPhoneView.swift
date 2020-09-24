//
//  AddPhoneView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class AddPhoneView: XWView {
    
    fileprivate let logoImage = XWImageView()
    fileprivate let titleLabel = XWLabel()
    fileprivate let phoneTF = XWTextField.init(Width: 10)
    fileprivate let bookBtn = XWButton()
    
    var addBlock : (()->Void)?
    
    fileprivate let bgView = XWView()
    
    var text : String {
        return phoneTF.text ?? ""
    }
    
    var textStr : String! {
        didSet{
            phoneTF.text = textStr
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        self.setCornerRadius(10)
        self.setShadow(offsetW: 0, offsetH: 0)
        
        logoImage.image = "add_friend_phone_icon".getImage().xw_imageChangeColor(UIColor.Theme.green)
        self.addSubview(logoImage)
        
        titleLabel.text = addPhoneNumber
        titleLabel.setFont(size: 16,isBold: true)
        self.addSubview(titleLabel)
        
        bgView.setCornerRadius(20)
        bgView.setborder(size: 1, color: UIColor.Theme.lineColor)
        self.addSubview(bgView)
        
        phoneTF.keyboardType = .numberPad
        phoneTF.placeholder = inputPhone
        phoneTF.setFont(size: 16)
        bgView.addSubview(phoneTF)
        
        bookBtn.addAction { (sender) in
            self.addBlock?()
        }
        bookBtn.setText(text: addressBook)
        bookBtn.backgroundColor = UIColor.Theme.green
        bookBtn.setFont(size: 16)
        bgView.addSubview(bookBtn)
        
        logoImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoImage.snp.right).offset(5)
            make.right.equalToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(10)
            make.centerY.equalTo(logoImage)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.right.equalTo(titleLabel)
            make.left.equalTo(logoImage)
            make.height.equalTo(40)
        }
        
        bookBtn.snp.makeConstraints { (make) in
            make.top.right.height.equalToSuperview()
            make.width.equalTo(80)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.height.equalTo(bookBtn)
            make.right.equalTo(bookBtn.snp.left)
        }
        
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
