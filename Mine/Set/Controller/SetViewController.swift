//
//  SetViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class SetViewController: XWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = set

        let setView = SetView()
        setView.signOutBlock = {
            
            AlertClass.setAlertView(msg: toSignOut, target: self, haveCancel: true) { (alert) in
                SignInPresenter.signOutAction()
                
                NotificationCenter.default.post(name: .updateUserNew, object: nil)
                NotificationCenter.default.post(name: .updateFriendList, object: nil)
                
                self.navigationController?.popViewController()
            }
            
        }
        self.view.addSubview(setView)
        
        setView.selectBlcok = {(index) in
            switch index {
            case 0:
                self.navigationController?.pushViewController(TermsViewController.init(title: privacyPolicy, text: privacyPolicyDetails))
            case 1:
                self.navigationController?.pushViewController(TermsViewController.init(title: userProtocol, text: userProtocolDetails))
            case 2:
                self.navigationController?.pushViewController(TermsViewController.init(title: paymentProtocol, text: paymentProtocolDetails))
            default:
                break
            }
        }
        
        setView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }
    

}
