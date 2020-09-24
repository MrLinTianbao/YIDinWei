//
//  ViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var mapView : MAMapView!
    fileprivate let locationManager = AMapLocationManager()
    fileprivate var movingAnnotation : MAAnimatedAnnotation!
    
    fileprivate var lineCoordinates = [CLLocationCoordinate2D]()
    
    fileprivate var location : CLLocation! {
        didSet{
            
            addMAPolyline()
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initMapView()
        initButtons()
    }
    
    fileprivate func initMapView() {
        
        mapView = MAMapView.init(frame: self.view.bounds)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        self.view.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.distanceFilter = 100
        locationManager.locatingWithReGeocode = true
        locationManager.startUpdatingLocation()
        
    }
    
    fileprivate func addMAPolyline() {
        
//        let latitude = self.location.coordinate.latitude
//        let longitude = self.location.coordinate.longitude
        
        lineCoordinates = [
        CLLocationCoordinate2D(latitude: 39.855539, longitude: 116.119037),
        CLLocationCoordinate2D(latitude: 39.88539, longitude: 116.250285),
        CLLocationCoordinate2D(latitude: 39.805479, longitude: 116.180859),
        CLLocationCoordinate2D(latitude: 39.788467, longitude: 116.226786),
        CLLocationCoordinate2D(latitude: 40.001442, longitude: 116.353915),
        CLLocationCoordinate2D(latitude: 39.989105, longitude: 116.360200)]
        
        let polyline: MAPolyline = MAPolyline(coordinates: &lineCoordinates, count: UInt(lineCoordinates.count))
        
        mapView.add(polyline)
        
        self.movingAnnotation = MAAnimatedAnnotation.init()
        self.movingAnnotation.coordinate = lineCoordinates.first!
        self.mapView.addAnnotation(self.movingAnnotation)
        
    }
    
    func initButtons() {
        let button1 =  UIButton.init(type: .roundedRect)
        button1.frame = CGRect.init(x: 10, y: 100, width: 70, height: 25)
        button1.backgroundColor = UIColor.red
        button1.setTitle("Go", for: .normal)
        button1.addTarget(self, action:#selector(self.button1), for: .touchUpInside)
        self.view.addSubview(button1)
        
        let button2 =  UIButton.init(type: .roundedRect)
        button2.frame = CGRect.init(x: 10, y: 150, width: 70, height: 25)
        button2.backgroundColor = UIColor.red
        button2.setTitle("Stop", for: .normal)
        button2.addTarget(self, action:#selector(self.button2), for: .touchUpInside)
        self.view.addSubview(button2)
    }
    
    @objc func button1() {
        self.movingAnnotation.coordinate = lineCoordinates[0];
        
        self.movingAnnotation.addMoveAnimation(withKeyCoordinates:&(self.lineCoordinates), count: UInt(self.lineCoordinates.count), withDuration: 5, withName: nil, completeCallback:nil);
    
    }
    
    @objc func button2() {
        if(self.movingAnnotation.allMoveAnimations() == nil) {
            return;
        }
        
        for item in self.movingAnnotation.allMoveAnimations() {
            let animation = item
            animation.cancel()
        }
        
        self.movingAnnotation.movingDirection = 0;
        self.movingAnnotation.coordinate = lineCoordinates[0];
    }

    
}

extension ViewController : MAMapViewDelegate,AMapLocationManagerDelegate {
    
    func mapViewRequireLocationAuth(_ locationManager: CLLocationManager!) {
        
        
        locationManager.requestAlwaysAuthorization()
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        
        MyLog("\(location.coordinate.latitude),\(location.coordinate.longitude),\(location.horizontalAccuracy)")
        
        if self.location == nil {
            self.location = location
        }
        
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
                
                let imge  =  UIImage.init(named: "WechatIMG565")
                annotationView?.image =  imge
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

