//
//  LocationViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class LocationViewController: XWViewController {
    
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

        let locationView = LocationView()
        locationView.locationBlock = {
            
            self.navigationController?.pushViewController(MyPathViewController())
            
        }
        self.view.addSubview(locationView)
        
        locationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
    

}



