//
//  MapViewController.swift
//  SquadUp-iOS
//
//  Created by Shaheen Sharifian on 2/17/16.
//  Copyright © 2016 Shaheen Sharifian. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var useCurrentLocationButton: FacebookLoginButton!
    @IBOutlet weak var locationMapView: MKMapView!
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationMapView.showsUserLocation = true
       
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        self.locationMapView.setRegion(region, animated: true)
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }
    
    @IBAction func useCurrentLocationPressed(sender: AnyObject) {
        let location = CLLocation(latitude: locationMapView.userLocation.coordinate.latitude, longitude: locationMapView.userLocation.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.locationMapView.userLocation.coordinate
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            var title = ""
            var subtitle = ""
            if error == nil {
                if let placemark = placemarks?[0] {
                    var subThoroughfare: String = ""
                    var thoroughfare: String = ""
                    var locality: String = ""
                    var postalCode: String = ""
                    var adminArea: String = ""
                    var country: String = ""
                    
                    if placemark.subThoroughfare != nil {
                        subThoroughfare = placemark.subThoroughfare!
                    }
                    if placemark.thoroughfare != nil {
                        thoroughfare = placemark.thoroughfare!
                    }
                    if placemark.locality != nil {
                        locality = placemark.locality!
                    }
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    if placemark.administrativeArea != nil {
                        adminArea = placemark.administrativeArea!
                    }
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    title = " \(subThoroughfare) \(thoroughfare) \(locality), \(adminArea)"
                    subtitle = " \(subThoroughfare) \(thoroughfare)";
                }
                
                annotation.title = title
                annotation.subtitle = "Current Location"
                self.locationMapView.addAnnotation(annotation)
                self.useCurrentLocationButton.enabled = false
            }

        }
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView?.canShowCallout = true
            
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func geoCode() {
        
    }

}
