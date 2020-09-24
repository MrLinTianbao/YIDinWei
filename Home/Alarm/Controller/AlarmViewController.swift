//
//  AlarmViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts
import MessageUI

class AlarmViewController: XWViewController {
    
    fileprivate let alarmView = AlarmView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = alarm

        alarmView.addBlock = {
            let contactVC = CNContactPickerViewController()
            contactVC.delegate = self
            self.present(contactVC, animated: true, completion: nil)
        }
        alarmView.friListBlock = {[weak self] in
            let vc = FriendListViewController()
            vc.phoneBlock = {(text) in
                self?.alarmView.phoneNum = text
                self?.alarmView.showSelectView()
            }
            self?.navigationController?.pushViewController(vc)
        }
        self.view.addSubview(alarmView)
        
        alarmView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

    

}

extension AlarmViewController : CNContactPickerDelegate {
    
    //MARK: 选择联系人
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
//        var phoneNumbers = [String]()

        for labeledValue in contact.phoneNumbers {
            let phoneValue = labeledValue.value
            let phoneNumber = phoneValue.stringValue
            let phoneNum = AlarmPresenter.phoneNumberFormat(phoneNum: phoneNumber)
//            phoneNumbers.append(phoneNum)
            
            if phoneNum != "" {
            
                self.alarmView.phoneNum = phoneNum
                self.alarmView.showSelectView()
                
                break
            }

        }
        
        
        
    }
    

    
    
}
