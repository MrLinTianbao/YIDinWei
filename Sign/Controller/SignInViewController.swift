//
//  SignInViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class SignInViewController: XWViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let signInView = SignInView()
        
        signInView.backBlock = {
            self.navigationController?.popViewController()
        }
        
        signInView.agreementBlock = {(text) in
            
            if text == "user" {
                self.navigationController?.pushViewController(TermsViewController.init(title: userProtocol, text: userProtocolDetails))
            }else if text == "privacy" {
                self.navigationController?.pushViewController(TermsViewController.init(title: privacyPolicy, text: privacyPolicyDetails))
            }
        }
        
        self.view.addSubview(signInView)
        
        signInView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
    }
    

    
}
