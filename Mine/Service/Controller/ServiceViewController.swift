//
//  ServiceViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class ServiceViewController: XWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = customService
        
        let serviceView = ServiceView()
        self.view.addSubview(serviceView)
        
        serviceView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
}
