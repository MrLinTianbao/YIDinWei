//
//  FirendPathViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class FirendPathViewController: XWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let friendPathView = CareAboutView.init(imageStr: "WechatIMG575")
        self.view.addSubview(friendPathView)
        
        friendPathView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    

    

}
