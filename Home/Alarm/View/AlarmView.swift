//
//  AlarmView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class AlarmView: XWView {
    
    fileprivate let imageView = XWImageView()
    fileprivate let addButton = XWButton()
    fileprivate let sendButton = XWButton()
    
    var addBlock : (()->Void)?
    var friListBlock : (()->Void)?
    
    var phoneNum = ""

    init() {
        super.init(frame: .zero)
        
        imageView.image = "alarm".getImage()
        self.addSubview(imageView)
        
        addButton.addAction { (sender) in
            self.showSelectView()
        }
        addButton.setText(text: "+ " + addContacts)
        addButton.setFont(size: 16)
        addButton.backgroundColor = UIColor.rgb(87, 114, 240)
        addButton.setCornerRadius(22)
        self.addSubview(addButton)
        
        sendButton.addAction { (sender) in
            AlarmPresenter.sendSignal()
        }
        sendButton.setText(text: sendSignal)
        sendButton.setFont(size: 16)
        sendButton.backgroundColor = UIColor.red
        sendButton.setCornerRadius(22)
        self.addSubview(sendButton)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(AlarmPresenter.getImageHeight(image: imageView.image!, imageW: ScreenW))
        }
        
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(33.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenW * 0.64)
            make.height.equalTo(44)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.top.equalTo(addButton.snp.bottom).offset(23)
            make.centerX.width.height.equalTo(addButton)
        }
        
    }
    
    public func showSelectView() {
        
        UIView.animate(withDuration: 0.2) {
            
            let addView = AddContactView.init(frame: self.bounds)
            
            addView.phoneNumer = self.phoneNum
            
            addView.addBlock = {
                
                if addView.phoneView.text == "" {
                    AlertClass.showToat(withStatus: inputPhone)
                    return
                }
                
                if addView.phoneView.text.count != 11 {
                    AlertClass.showToat(withStatus: phoneError)
                    return
                }
                
                AlertClass.waiting(isAdd)
                
                AlarmPresenter.addFriend(parameters: ["phone":addView.phoneView.text,"style":"1"])
                self.phoneNum = ""
                addView.removeFromSuperview()
            }
            
            addView.bookBlock = {
                self.phoneNum = ""
                addView.removeFromSuperview()
                self.addBlock?()
            }
            addView.friListBlock = {
                self.phoneNum = ""
                addView.removeFromSuperview()
                self.friListBlock?()
            }
            
            UIApplication.shared.keyWindow?.addSubview(addView)
            
            addView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            addView.showSelectView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
