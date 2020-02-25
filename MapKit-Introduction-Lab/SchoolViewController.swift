//
//  ViewController.swift
//  MapKit-Introduction-Lab
//
//  Created by Lilia Yudina on 2/25/20.
//  Copyright © 2020 Lilia Yudina. All rights reserved.
//

import UIKit
import MapKit

class SchoolViewController: UIViewController {
    
    @IBOutlet weak var schoolMap: MKMapView!
    
    
    private let locationSession = CoreLocationSession()
    
    private var schools = [School]()
    
    private var isShowingNewAnnotations = false
    
    private var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        schoolMap.showsUserLocation = true
        schoolMap.delegate = self
        loadSchools()
        loadMapView()
    }
    private func loadSchools() {
        SchoolAPIClient.getSchools { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error getting books: \(appError)")
            case .success(let schools):
                self?.schools = schools
                DispatchQueue.main.async {
                     self?.loadMapView()
                }
               
            }
        }
        
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
      var annotations = [MKPointAnnotation]()
        
      for location in schools {
        let annotation = MKPointAnnotation()
        guard let lat = Double(location.latitude), let long = Double(location.longitude) else { break }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = location.schoolName
        annotation.coordinate = coordinate
        annotations.append(annotation)
      }
      return annotations
    }
    
    private func loadMapView() {
      let annotations = makeAnnotations()
      schoolMap.showAnnotations(annotations, animated: true)
    }

}

extension SchoolViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("didSelect")
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else {
      return nil
    }
    let identifier = "locationAnnotation"
    var annotationView: MKPinAnnotationView

    if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
      annotationView = dequeueView
    } else {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView.canShowCallout = true
    }
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    print("calloutAccessoryControlTapped")
  }
}
