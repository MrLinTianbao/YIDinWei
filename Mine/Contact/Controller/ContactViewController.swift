//
//  ContactViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/11.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts
import MessageUI

class ContactViewController: XWViewController {
    
    fileprivate let contactView = ContactView()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = selectContact
        
        contactView.addBlock = {
            let contactVC = CNContactPickerViewController()
            contactVC.delegate = self
            self.present(contactVC, animated: true, completion: nil)
        }
        contactView.friListBlock = {
            let vc = FriendListViewController()
            vc.phoneBlock = {[weak self](text) in
                self?.contactView.phoneNum = text
                self?.contactView.showSelectView()
            }
            self.navigationController?.pushViewController(vc)
        }
        self.view.addSubview(contactView)
        
        contactView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
    }
    
}

extension ContactViewController : CNContactPickerDelegate {
    
    //MARK: 选择联系人
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
//        var phoneNumbers = [String]()

        for labeledValue in contact.phoneNumbers {
            let phoneValue = labeledValue.value
            let phoneNumber = phoneValue.stringValue
            let phoneNum = AlarmPresenter.phoneNumberFormat(phoneNum: phoneNumber)
//            phoneNumbers.append(phoneNum)
            
            if phoneNum != "" {
            
                self.contactView.phoneNum = phoneNum
                self.contactView.showSelectView()
                
                break
            }

        }
        
        
        
    }
    

    
    
}
