//
//  HomeView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/5.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class HomeView: XWView {
    
    var pushBlock : ((Int)->Void)?
    
    fileprivate let cellId = "homeCell"
    fileprivate let cellId2 = "mySelfCell"
    
    var dataArray = [HomeModel]()
    
    fileprivate lazy var locationManager = AMapLocationManager()
    
    fileprivate lazy var search = AMapSearchAPI()
    
    fileprivate var location = "" //当前位置
    fileprivate lazy var coordinate = CLLocation()
    
    fileprivate var timer : Timer!
    
    fileprivate var sounds = 0
    
    var addBlock : (()->Void)?
    var helpBlock : (()->Void)?
    var noticeBlock : (()->Void)?
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        let headView = XWView.init(frame: .init(x: 0, y: 0, width: ScreenW, height: RATIO_H(maxNum: 10)))
        headView.backgroundColor = UIColor.Theme.bgColor
        tableView.tableHeaderView = headView
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(HomeCell.self, forCellReuseIdentifier: cellId)
        tableView.register(MyLocationCell.self, forCellReuseIdentifier: cellId2)
        return tableView
        
    }()
    
    fileprivate lazy var addButton : XWButton = {
        
        let button = XWButton()
        button.setFont(size: 16)
        button.setText(text: addCareAboutPeople)
        button.backgroundColor = UIColor.Theme.red
        button.setCornerRadius(20)
        return button
        
    }()
    
    fileprivate lazy var helpButton : XWButton = {
        
        let button = XWButton()
        button.backgroundColor = UIColor.clear
        button.setImage(image: "sos")
        return button
        
    }()

    init() {
        super.init(frame: .zero)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getTimeAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: .updateFriendList, object: nil)
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.window?.rootViewController?.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.backgroundColor = UIColor.Theme.bgColor
        
        self.addSubview(tableView)
        
        self.addSubview(addButton)
        self.addSubview(helpButton)
        
        addButton.addAction { (sender) in
            self.addBlock?()
        }
        
        helpButton.addAction { (sender) in
            self.helpBlock?()
        }
        
        getCurrentLocation()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        helpButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(addButton)
            make.right.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        AlertClass.setRefresh(with: tableView, headerAction: {[weak self] in
            NotificationCenter.default.post(name: .getUnreadMsg, object: nil)
            self?.getData()
        }, footerAction: nil)
        
        tableView.mj_header?.beginRefreshing()
        
    }
    
    fileprivate func getCurrentLocation() {
        
        search?.delegate =  self
        
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.startUpdatingLocation()
        
    }
    
    @objc fileprivate func getTimeAction() {
        
        sounds += 1
    }
    
    //MARK: 获取数据
    @objc fileprivate func getData() {
        
        HomePresenter.getUserPods(parameters: ["style":"0"], success: { (array) in
            
            self.tableView.mj_header?.endRefreshing()
            self.dataArray.removeAll()
            self.dataArray = array
            self.tableView.reloadData()
            
        }) {
            
            self.tableView.mj_header?.endRefreshing()
            
        }
    }
    
    //MARK: 好友设置
    fileprivate func setFriend(section:Int,index:Int) {
        
        let model = dataArray[section]
        
        switch index {
        case 1:
            
            let noteView = ChangeNoteView()
            noteView.changeBlock = {(text) in
                
                noteView.removeFromSuperview()
                
                AlertClass.show(isChange)
                HomePresenter.setFriendNote(parameters: ["id":model.id ?? "","nickName":text]) {
                    AlertClass.stop()
                    AlertClass.showToat(withStatus: changSuccess)
                    self.getData()
                }
            }
            window?.addSubview(noteView)
            
            noteView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            noteView.showDateView()
            
            
        case 2:
            
            AlertClass.show(isDelete)
            HomePresenter.deleteFriend(parameters: ["userId":model.friendUserId ?? ""]) {
                AlertClass.stop()
                AlertClass.showToat(withStatus: deleteSuccess)
                self.getData()
            }
        case 3:
            for view in window!.subviews {
                if view is HomeSetView {
                    view.removeFromSuperview()
                    break
                }
            }
            
            self.pushBlock?(section)
            
            
            
        default:
            break
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomeView : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else{
            return dataArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            if location == "" {
                return 70
            }else{
                return 70 + self.location.xw_calculateHeigh(withWidth: ScreenW-40, size: 13, lineSpacing: 0)
            }
        }else{
            
            let height = 50 + (dataArray[indexPath.row].address?.xw_calculateHeigh(withWidth: ScreenW-94, size: 13, lineSpacing: 0) ?? 0)
            
            return height
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath) as? MyLocationCell
            cell?.location = self.location
            cell?.selectionStyle = .none
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HomeCell
                    cell?.selectionStyle = .none
                    cell?.editBtn.tag = indexPath.row
                    cell?.editBtn.addAction({ (sender) in
                        let homeSetView = HomeSetView()
                        homeSetView.pushBlock = {(index) in
                            self.setFriend(section: indexPath.row, index: index)
                        }
                        self.window?.addSubview(homeSetView)
                        
                        homeSetView.snp.makeConstraints { (make) in
                            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
                        }
                        
                        homeSetView.tableView.animationWithAlertViewWithView()
                    })
                    
                    cell?.model = dataArray[indexPath.row]
                    return cell!
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            self.pushBlock?(indexPath.row)
        }

    }
    
}

extension HomeView : AMapLocationManagerDelegate,AMapSearchDelegate {
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        
        AlertClass.showToat(withStatus: error.localizedDescription)
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        
                //逆地址编码
                let regeo = AMapReGeocodeSearchRequest()
                regeo.location = AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
                regeo.requireExtension = true
        
                self.coordinate = location

                search?.aMapReGoecodeSearch(regeo)

//            if self.sounds > 5 && isLogin {
//
//                self.sounds = 0
//                let longitude = HomePresenter.saveDecimalPoint(digital: location.coordinate.longitude)
//
//                let latitude = HomePresenter.saveDecimalPoint(digital: location.coordinate.latitude)
//
//                        HomePresenter.getAddress(parameters: ["key":geoWebKey,"location":"\(longitude),\(latitude)"]) { (json) in
//
//                            HomePresenter.uploadLocation(parameters: ["address":json["regeocode"]["formatted_address"].stringValue,"city":json["regeocode"]["addressComponent"]["city"].stringValue,"lat":"\( latitude)","lng":"\(longitude)"])
//
//                        }
//            }
        
                
    }

    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        if let regeocode = response.regeocode {
        
            if self.location != regeocode.formattedAddress { //位置更新
                self.location = regeocode.formattedAddress
                self.tableView.reloadData()
                
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(self.coordinate) { (placemarks, error) in
                    
                    //判断是否有错误或者placemarks是否为空
                    if error != nil || placemarks?.count == 0 {
                        MyLog(error?.localizedDescription)
                    }else{
                        if let placemark = placemarks?.first {
                            
                            if self.sounds > 5 && isLogin {
                
                                self.sounds = 0
                                
                                let longitude = HomePresenter.saveDecimalPoint(digital: self.coordinate.coordinate.longitude)
                                
                                let latitude = HomePresenter.saveDecimalPoint(digital: self.coordinate.coordinate.latitude)
                                HomePresenter.uploadLocation(parameters: ["address":self.location,"city":placemark.locality ?? "","lat":"\( latitude)","lng":"\(longitude)"])
                                
                            }

                        
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        
//        AlertClass.showToat(withStatus: error.localizedDescription)
        
    }
    
}
