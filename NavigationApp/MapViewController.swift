//
//  MapViewController.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 09.06.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    private var observation: NSKeyValueObservation?
    private var firstUserLocation: CLLocation? {
        didSet {
            // Set first user location and move camera to it. When invalidate observation.
            guard oldValue == nil, let firstLocation = firstUserLocation else { return }
            mapView.camera = GMSCameraPosition(target: firstLocation.coordinate, zoom: 15)
            observation?.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        // Listen to the myLocation property of GMSMapView.
        observation = mapView.observe(\.myLocation, options: [.new]) { [weak self] mapView, _ in
            self?.firstUserLocation = mapView.myLocation
        }
    }
    
    deinit {
        observation?.invalidate()
    }
}


// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    }

}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      guard status == .authorizedWhenInUse else { return }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("did update locations")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with error")
    }

}

