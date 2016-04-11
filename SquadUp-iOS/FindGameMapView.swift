//
//  FindGameMapView.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 4/10/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import MapKit

class FindGameMapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Find Games Near You"
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView = MKMapView()
        mapView.frame = view.frame
        mapView.mapType = .Standard
        mapView.delegate = self
        mapView.zoomEnabled = true
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let locationCoordinate = userLocation.coordinate
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}
