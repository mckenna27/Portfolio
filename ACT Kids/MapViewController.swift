//
//  MapViewController.swift
//  ACT Kids
//
//  Created by Patrick E. McKenna on 3/10/18.
//  Copyright © 2018 Patrick McKenna. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate
{
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var locationManager: CLLocationManager!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func showSearchBar(_ sender: Any)
    {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self as UISearchBarDelegate
        present(searchController, animated: true, completion: nil)
    }
    


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        
        
        let Legion = Participants(title: "West Scranton Legion Post 920", coordinate: CLLocationCoordinate2D(latitude: 41.379611, longitude: -75.692065), sportType: "Baseball", businessAddress: "2929 Birney Ave., Scranton, PA 18505", phoneNumber: "(570) 342-7498")
        let Biddy = Participants(title: "Dunmore Biddy Basketball", coordinate: CLLocationCoordinate2D(latitude: 41.421821, longitude: -75.635288), sportType: "Basketball", businessAddress: "1607 Roosevelt Ave., Dunmore, PA 18512", phoneNumber: "(570) 342-2902")
        let Cedar = Participants(title: "Cedar Bike and Paddle", coordinate: CLLocationCoordinate2D(latitude: 41.398357, longitude: -75.665674), sportType: "Biking", businessAddress: "629 Pittson Avenue., Scranton, PA 18505", phoneNumber: "(570) 344-3416")
        let SouthSide = Participants(title: "South Side Bowl", coordinate: CLLocationCoordinate2D(latitude: 41.401210, longitude: -75.673355), sportType: "Bowling", businessAddress: "125 Beech St., Scranton, PA 18505", phoneNumber: "(570) 961-5213")
        let Genesis = Participants(title: "World Cup Genesis", coordinate: CLLocationCoordinate2D(latitude: 41.449622, longitude: -75.588880), sportType: "Cheerleading", businessAddress: "913 Stanton Ave., Olyphant, PA 18447", phoneNumber: "(570) 383-1910")
        let Keystone = Participants(title: "Keystone Crossfit", coordinate: CLLocationCoordinate2D(latitude: 41.419446, longitude: -75.600803), sportType: "Crossfit", businessAddress: "1000 Dunham Dr., Dunmore, PA 18512", phoneNumber: "(570) 851-0898")
        let Ballroom = Participants(title: "Ballroom ONE", coordinate: CLLocationCoordinate2D(latitude: 41.435875, longitude: -75.633467), sportType: "Ballroom Dance", businessAddress: "2500 Adams Ave., Scranton, PA 18509", phoneNumber: "(570) 445-6439")
        let Birchwood = Participants(title: "Birchwood Fitness", coordinate: CLLocationCoordinate2D(latitude: 41.482479, longitude: -75.687294), sportType: "Fitness Center", businessAddress: "105 Edella Rd. South Abington Township, PA 18411", phoneNumber: "(570) 586-4030")
        let Crossmolina = Participants(title: "Crossmolina School of Dance", coordinate: CLLocationCoordinate2D(latitude: 41.417798, longitude: -75.641548), sportType: "Irish Step Dancing", businessAddress: "317 W. Grove St., Dunmore, PA 18510", phoneNumber: "(570) 344-6652")
        let United = Participants(title: "United Sports Academy", coordinate: CLLocationCoordinate2D(latitude: 41.429467, longitude: -75.612937), sportType: "Gymnastics", businessAddress: "1035 Reeves St., Dunmore, PA 18512", phoneNumber: "(570) 963-5477")
        let Academy = Participants(title: "Academy of Asian Martial Arts", coordinate: CLLocationCoordinate2D(latitude: 41.402775, longitude: -75.667856), sportType: "Martial Arts", businessAddress: "215 Hickory St., Scranton, PA 18505", phoneNumber: "(570) 445-5477" )
        let SPA = Participants(title: "SPA Karate", coordinate: CLLocationCoordinate2D(latitude: 41.479286, longitude: -75.598825), sportType: "Martial Arts", businessAddress: "1536 Main St., Peckville, PA 18542", phoneNumber: "(570) 262-1386")
        let Tiger = Participants(title: "Tiger Karate Academy", coordinate: CLLocationCoordinate2D(latitude: 41.496231, longitude: -75.541552), sportType: "Martial Arts", businessAddress: "440 Main St., Archbald, PA 18403", phoneNumber: "(570) 876-KICK")
    
    mapView.addAnnotations([Legion, Biddy, Cedar, SouthSide, Genesis, Keystone, Ballroom, Birchwood, Crossmolina, United, Academy, SPA, Tiger])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }
    func setRegion(_ region: MKCoordinateRegion,animated: Bool)
    {
      
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        //1
        let identifier = "Participants"
        //2
        if annotation is Participants {
            // 3
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                //4
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                // 5
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                // 6
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        // 7
        return nil
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let Participants = view.annotation as! Participants
        let placeName = Participants.title
        let address = Participants.businessAddress
        
        let ac = UIAlertController(title: placeName, message: address,  preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}
