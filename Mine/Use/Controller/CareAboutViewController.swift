//
//  CareAboutViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class CareAboutViewController: XWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let careAboutView = CareAboutView.init(imageStr: "WechatIMG574")
        self.view.addSubview(careAboutView)
        
        careAboutView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    

    

}
