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
    var currentLocationToPass: String!
    var lobbyNamePassed: String = ""
    var descriptionPassed: String = ""
    var numPlayersPassed: String = ""
    var sportPassed: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMapView.delegate = self
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationMapView.showsUserLocation = true
        searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
                }
                self.currentLocationToPass = title
                annotation.title = title
                annotation.subtitle = "Current Location"
                self.locationMapView.addAnnotation(annotation)
                self.useCurrentLocationButton.enabled = false
            }
            
        }
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MKUserLocation) {
            print("This guy....");
            return nil;
        }
        let reuseId = "pin";
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView;
        if(pinView == nil) {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId);
            pinView!.canShowCallout = true;
            pinView!.animatesDrop = true;
        }
        let rightButton = UIButton(type: UIButtonType.DetailDisclosure)
        pinView?.rightCalloutAccessoryView = rightButton;
        return pinView;
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegueWithIdentifier(SEGUE_MAP_TO_CREATE_LOBBY, sender: nil)
    }
    

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.locationMapView.removeAnnotations(self.locationMapView.annotations)
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = self.locationMapView.region
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { (response, error) -> Void in
            if error != nil {
                print("ERROR")
            } else if response?.mapItems.count == 0 {
                print("No Places found")
            } else {
                print("Found")
                for item in response!.mapItems {
                    let annotation = MKPointAnnotation()
                    var title = ""
                    var subThoroughfare: String = ""
                    var thoroughfare: String = ""
                    var locality: String = ""
                    var postalCode: String = ""
                    var adminArea: String = ""
                    var country: String = ""
                    
                    if item.placemark.subThoroughfare != nil {
                        subThoroughfare = item.placemark.subThoroughfare!
                    }
                    if item.placemark.thoroughfare != nil {
                        thoroughfare = item.placemark.thoroughfare!
                    }
                    if item.placemark.locality != nil {
                        locality = item.placemark.locality!
                    }
                    if item.placemark.postalCode != nil {
                        postalCode = item.placemark.postalCode!
                    }
                    if item.placemark.administrativeArea != nil {
                        adminArea = item.placemark.administrativeArea!
                    }
                    if item.placemark.country != nil {
                        country = item.placemark.country!
                    }
                    title = " \(subThoroughfare) \(thoroughfare) \(locality), \(adminArea)"
                    self.currentLocationToPass = title
                    annotation.title = item.name
                    annotation.subtitle = title
                    annotation.coordinate = (item.placemark.location?.coordinate)!
                    self.locationMapView.addAnnotation(annotation)
                }
            }
        }
        dismissKeyboard()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_MAP_TO_CREATE_LOBBY {
            let vc = segue.destinationViewController as! CreateNewLobbyViewController
            vc.passedLocationString = self.currentLocationToPass
            vc.passedLobbyName = self.lobbyNamePassed
            vc.passedDescription = self.descriptionPassed
            vc.numPlayersPassed = self.numPlayersPassed
            vc.sportPassed = self.sportPassed

        }
    }
    
}
