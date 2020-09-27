//
//  UnlockViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class UnlockViewController: XWViewController {
    
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

        let unLockView = UnlockView()
        unLockView.backBlock = {
            self.navigationController?.popViewController()
        }
        unLockView.agreementBlock = {(text) in
            if text == "privacy" {
                self.navigationController?.pushViewController(TermsViewController.init(title: paymentAgreement, text: paymentProtocolDetails))
            }
        }
        self.view.addSubview(unLockView)
        
        unLockView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
    }
    

    

}
