//
//  CareViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts
import MessageUI

class CareViewController: XWViewController {
    
    fileprivate let careView = CareView()
    
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

        careView.backBlock = {
            self.navigationController?.popViewController()
        }
        self.view.addSubview(careView)
        
        careView.addBlock = {
            let contactVC = CNContactPickerViewController()
            contactVC.delegate = self
            self.present(contactVC, animated: true, completion: nil)
        }
        
        careView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    

}

extension CareViewController : CNContactPickerDelegate {
    
    //MARK: 选择联系人
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
//        var phoneNumbers = [String]()

        for labeledValue in contact.phoneNumbers {
            let phoneValue = labeledValue.value
            let phoneNumber = phoneValue.stringValue
            let phoneNum = AlarmPresenter.phoneNumberFormat(phoneNum: phoneNumber)
//            phoneNumbers.append(phoneNum)
            
            if phoneNum != "" {
            
                self.careView.phoneNumber = phoneNum
                
                break
            }

        }
        
        
        
    }
    

    
    
}
