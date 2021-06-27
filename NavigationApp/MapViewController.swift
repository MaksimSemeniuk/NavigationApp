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
    @IBOutlet weak var recordInfoView: UIView!
    @IBOutlet weak var recordInfoStackView: UIStackView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recordInfoViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var recordInfoViewHeightConstraint: NSLayoutConstraint!
    
    private let locationManager = CLLocationManager()
    private let path = GMSMutablePath()
    private var observation: NSKeyValueObservation?
    private var isRecording = false
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
        // Listen to the myLocation property of GMSMapView.
        observation = mapView.observe(\.myLocation, options: [.new]) { [weak self] mapView, _ in
            self?.firstUserLocation = mapView.myLocation
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        print("Size: \(recordInfoView.intrinsicContentSize.height)")
        mapView.padding = UIEdgeInsets(
            top: view.safeAreaInsets.top,
            left: 0,
            bottom: recordInfoViewHeightConstraint.constant,
            right: 0)
    }
    
    deinit {
        observation?.invalidate()
    }
        
    private func addCoordinateToPath(coordinate: CLLocationCoordinate2D) {
        path.add(coordinate)
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView
    }
    
    private func startRouteRecording() {
        recordButton.setTitle("Stop recording", for: .normal)
        locationManager.startUpdatingLocation()
    }
    
    private func stopRouteRecording() {
        recordButton.setTitle("Start recording", for: .normal)
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - IBActions
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        isRecording = !isRecording
        isRecording ? startRouteRecording() : stopRouteRecording()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
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
        guard let location = locations.first else { return }
        addCoordinateToPath(coordinate: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with error")
    }

}

