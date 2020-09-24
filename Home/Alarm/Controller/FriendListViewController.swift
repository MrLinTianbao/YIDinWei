//
//  FriendListViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class FriendListViewController: XWViewController {
    
    var phoneBlock : ((String)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = friendList

        let listView = SelectFriendListView()
        listView.phoneBlock = {(text) in
            self.phoneBlock?(text)
            self.navigationController?.popViewController()
        }
        self.view.addSubview(listView)
        
        listView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    

    
}

