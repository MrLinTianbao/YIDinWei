//
//  MyPathViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/7.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MyPathViewController: XWViewController {
    
    fileprivate var userId = ""
    
    init(userId:String?=UserInfo.id,title:String?=myPath) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title!
        self.userId = userId!
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let myPathView = MyPathView.init(userId: userId)
        self.view.addSubview(myPathView)
        
        myPathView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    

    

}
