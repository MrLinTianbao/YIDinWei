//
//  AddContactView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class AddContactView: XWView {
    
    var phoneNumer : String! {
        didSet{
            phoneView.textStr = phoneNumer
        }
    }
    
    fileprivate var bgView : XWView!
    
    fileprivate let titleLabel = XWLabel()
    fileprivate let cancelBtn = XWButton()
    
    let phoneView = InputPhoneView.init(frame: .init(x: 0, y: 40, width: ScreenW, height: 50))
    fileprivate let listView = FriendListView()
    
    fileprivate let confirmBtn = XWButton()
    
    var bookBlock : (()->Void)?
    var friListBlock : (()->Void)?
    var addBlock : (()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.Theme.alpha
        
        bgView = XWView.init(frame: .init(x: 0, y: ScreenH, width: ScreenW, height: isIPhoneX ? 220 :  210))
        self.addSubview(bgView)
        
        
        titleLabel.text = addContact
        titleLabel.textAlignment = .center
        titleLabel.setFont(size: 16)
        bgView.addSubview(titleLabel)
        
        cancelBtn.addAction { (sender) in
            self.removeSelectView()
        }
        cancelBtn.setImage(image: "ic_close")
        bgView.addSubview(cancelBtn)
        
        
        phoneView.bookButton.addAction { (sender) in
            self.bookBlock?()
        }
        bgView.addSubview(phoneView)
        
        listView.frame = .init(x: 0, y: 90, width: ScreenW, height: 50)
        listView.addAction {(sender) in
            self.friListBlock?()
        }
        bgView.addSubview(listView)
        
        confirmBtn.addAction { (sender) in
            self.addBlock?()
        }
        confirmBtn.backgroundColor = UIColor.Theme.green
        confirmBtn.setText(text: global_confirm)
        confirmBtn.setFont(size: 16)
        bgView.addSubview(confirmBtn)
        
        
    }
    
    override func layoutSubviews() {
        
        titleLabel.frame = .init(x: ScreenW/4, y: 0, width: ScreenW/2, height: 40)
        cancelBtn.frame = .init(x: ScreenW-50, y: 0, width: 40, height: 40)
        confirmBtn.frame = .init(x: 0, y: 160, width: ScreenW, height: isIPhoneX ? 60 : 50)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        removeSelectView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func removeSelectView() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.bgView.y = ScreenH
        }) { (flag) in
            self.removeFromSuperview()
        }
    }
    
    public func showSelectView() {
        
        UIView.animate(withDuration: 0.2) {
            self.bgView.maxY = ScreenH
        }
        
    }

}
