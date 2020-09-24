//
//  MyPathView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/7.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MyPathView: XWView {

    fileprivate var movingAnnotation : MAAnimatedAnnotation!
        
        fileprivate var lineCoordinates = [CLLocationCoordinate2D]()
        
        var locationBlock : (()->Void)?
        
        fileprivate var location : CLLocation!
        
        fileprivate lazy var mapView : MAMapView = {
           
            let mapView = MAMapView()
            mapView.delegate = self
            mapView.zoomLevel = 17
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            mapView.showsCompass = false
            mapView.customizeUserLocationAccuracyCircleRepresentation = true
            return mapView
            
        }()
        
        fileprivate lazy var locationManager : AMapLocationManager = {
            
            let locationManager = AMapLocationManager()
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.locatingWithReGeocode = true
            return locationManager
            
        }()
        
        fileprivate lazy var datePathView : DatePathView = {
            
            let datePathView = DatePathView()
            return datePathView
            
        }()
    
        fileprivate var userId = ""

        init(userId:String) {
            super.init(frame: .zero)
            
            self.userId = userId
            
            initMapView()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        fileprivate func initMapView() {
                
            self.addSubview(mapView)
            
            self.addSubview(datePathView)
            
            locationManager.startUpdatingLocation()
            
            mapView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
            }
            
            datePathView.snp.makeConstraints { (make) in
                make.bottom.equalTo(RATIO_H(maxNum: -70))
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.height.equalTo(100)
            }
            
            datePathView.selectBlock = {(index) in
                let dateView = SelectDateView()
                dateView.title = index == 1 ? startTime : endTime
                self.window?.addSubview(dateView)
                
                dateView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
                
                dateView.dateBlock = {(time) in
                    if index == 1 {
                        self.datePathView.startText = time
                    }else{
                        self.datePathView.endText = time
                    }
                }
                
                dateView.showDateView()
            }
        
            
            datePathView.locationBlock = {
                self.addMAPolyline()
            }
                
        }
            
        fileprivate func addMAPolyline() {
            
            LocationPresenter.getUserPossList(parameters: ["userId":self.userId,"startTime":self.datePathView.startText,"endTime":self.datePathView.endText]) { (array) in
                
                self.lineCoordinates.removeAll()
                self.mapView.removeOverlays(self.mapView.overlays)
                self.mapView.removeAnnotations(self.mapView.annotations)
                
                for model in array {
                    
                    self.lineCoordinates.append(CLLocationCoordinate2D(latitude: (model.lat?.double())!, longitude: (model.lng?.double())!))
                    
                    let polyline: MAPolyline = MAPolyline(coordinates: &self.lineCoordinates, count: UInt(self.lineCoordinates.count))

                    self.mapView.add(polyline)

                    
                    
                }
                
                if self.lineCoordinates.count > 0 {
                    self.movingAnnotation = MAAnimatedAnnotation.init()
                    self.movingAnnotation.coordinate = self.lineCoordinates[0];
                    self.mapView.addAnnotation(self.movingAnnotation)
                    
                    self.movingAnnotation.addMoveAnimation(withKeyCoordinates:&(self.lineCoordinates), count: UInt(self.lineCoordinates.count), withDuration: 5, withName: nil, completeCallback:nil);
                }
                
                
                
            }
            

            
        }
            
    
}

extension MyPathView : MAMapViewDelegate,AMapLocationManagerDelegate {
    
    func mapViewRequireLocationAuth(_ locationManager: CLLocationManager!) {
        
        
        locationManager.requestAlwaysAuthorization()
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        
//        MyLog("\(location.coordinate.latitude),\(location.coordinate.longitude),\(location.horizontalAccuracy)")
        
        
        self.location = location
        
        
        
        
        if (reGeocode != nil) {
            MyLog(reGeocode)
        }
        
    }
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        
        if overlay.isKind(of: MAPolyline.self) {
            
            
            let renderer: MAPolylineRenderer = MAPolylineRenderer(overlay: overlay)
                       renderer.lineWidth = 8.0
//                       renderer.strokeColor = UIColor.cyan
            
            renderer.strokeImage = "arrowTexture".getImage()
                       
            return renderer
        }
        
        return nil
        
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if (annotation.isKind(of: MAPointAnnotation.self))
        {
            let pointReuseIndetifier = "myReuseIndetifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            if (annotationView == nil)
            {
                annotationView =  MAPinAnnotationView.init(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
                
                if self.location != nil {
                    if annotation.coordinate.latitude == self.location.coordinate.latitude && annotation.coordinate.longitude == self.location.coordinate.longitude { //我的位置
                        
                        annotationView?.image =  "WechatIMG565".getImage()
                        
                    }else{
                        annotationView?.image =  "userPosition".getImage()
                    }
                }else{
                    annotationView?.image =  "WechatIMG565".getImage()
                }
                
                
                
                
            }
            
            annotationView?.canShowCallout = true
            annotationView?.animatesDrop = false
            annotationView?.isDraggable = false
            annotationView?.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
            
            return annotationView;
        }
        
        return nil;
        
    }
    
}
