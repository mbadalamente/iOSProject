//
//  MapViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 4/27/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var receivingLocation: String = ""
    let regionRadius: CLLocationDistance = 1000
    var matchingSearchItems: [MKMapItem] = [MKMapItem]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.text = receivingLocation
        let location = CLLocation(latitude: 41.41992, longitude: -72.89771)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        locationTextField.delegate = self
    }
    
    // MARK: Map
    @IBAction func searchMap(_ sender: Any) {
        performSearch()
    }
    func performSearch(){
        mapView.removeAnnotations(mapView.annotations)

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = locationTextField!.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            if error != nil {
               // print("An error occurred")
            } else if response!.mapItems.count == 0 {
              //  print("Nothing was returned")
            } else {
              //  print("We got results")
                for item in response!.mapItems {
                    // Process the results into our array
                    self.matchingSearchItems.append(item as MKMapItem)
                    
                    // Drop the pin on the map...
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }

}
extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch()
        return true
    }
}
