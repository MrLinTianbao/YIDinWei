//
//  SelectDateView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/7.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class SelectDateView: XWView {
    
    let bgView = XWView()
    
    fileprivate let timeLabel = XWLabel()
    fileprivate let cancelBtn = XWButton()
    fileprivate let confirmBtn = XWButton()
    
    fileprivate var dateTime = ""
    
    var title : String! {
        didSet{
            timeLabel.text = title
            
            if title == startTime {
                dateTime = getCurrentTime().components(separatedBy: " ").first! + " 00:00:00"
            }else{
                dateTime = getCurrentTime()
            }
        }
    }
    
    var dateBlock : ((String)->Void)?
    
    fileprivate lazy var datePicker : UIDatePicker = {
        
        let datePicker = UIDatePicker()
         // 设置日期选择器模式:日期模式
        datePicker.datePickerMode = .date
        // 设置可供选择的最小时间：昨天
        datePicker.locale = Locale.init(identifier: "zh_CN")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
        return datePicker
        
    }()

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.Theme.alpha
        
        bgView.frame = .init(x: 0, y: ScreenH, width: ScreenW, height: 200)
        self.addSubview(bgView)
        
        timeLabel.frame = .init(x: ScreenW/4, y: 0, width: ScreenW/2, height: 40)
        timeLabel.textAlignment = .center
        timeLabel.setFont(size: 18, isBold: true)
        bgView.addSubview(timeLabel)
        
        cancelBtn.addAction { (sender) in
            self.removeDateView()
        }
        cancelBtn.frame = .init(x: 0, y: 0, width: 80, height: 40)
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.setText(text: global_cancel)
        cancelBtn.setFont(size: 16)
        cancelBtn.setTextColor(color: UIColor.blue)
        bgView.addSubview(cancelBtn)
        
        confirmBtn.addAction { (sender) in
            
            self.dateBlock?(self.dateTime)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.bgView.y = ScreenH
            }) { (flag) in
                self.removeFromSuperview()
            }
            
        
        }
        confirmBtn.frame = .init(x: ScreenW-80, y: 0, width: 80, height: 40)
        confirmBtn.backgroundColor = UIColor.clear
        confirmBtn.setText(text: global_confirm)
        confirmBtn.setFont(size: 16)
        confirmBtn.setTextColor(color: UIColor.blue)
        bgView.addSubview(confirmBtn)
        
        datePicker.frame = .init(x: 0, y: 40, width: ScreenW, height: 150)
        bgView.addSubview(datePicker)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeDateView()
    }
    
    @objc fileprivate func datePickerValueChanged(sender:UIDatePicker) {
        
        //获取当前日期和时间
        let currentDate = sender.date
        //创建格式转换器
        let dateformatter = DateFormatter()
        
        //设置格式
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let currentDate_string = dateformatter.string(from: currentDate)
        
        if title == startTime {
            dateTime = currentDate_string.components(separatedBy: " ").first! + " 00:00:00"
        }else{
            dateTime = currentDate_string
        }
        
        
        
    }
    
    fileprivate func removeDateView() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.bgView.y = ScreenH
        }) { (flag) in
            self.removeFromSuperview()
        }

    }
    
    public func showDateView() {
        
        UIView.animate(withDuration: 0.2) {
            self.bgView.maxY = ScreenH
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
