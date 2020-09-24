//
//  TermsViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class TermsViewController: XWViewController {
    
    fileprivate let textView = UITextView()
    fileprivate var text = ""
    
    init(title:String,text:String) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
    }
    

    

}
