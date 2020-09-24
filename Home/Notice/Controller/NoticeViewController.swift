//
//  NoticeViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class NoticeViewController: XWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = notice

        let noticeView = NoticeView()
        self.view.addSubview(noticeView)
        
        noticeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }


    }
    

    

}
