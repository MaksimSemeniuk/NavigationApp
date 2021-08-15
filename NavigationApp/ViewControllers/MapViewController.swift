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
    @IBOutlet weak var saveButton: CustomButton!
    @IBOutlet weak var recordInfoViewHeightConstraint: NSLayoutConstraint!
    
    private let recordInfoViewMinHeight: CGFloat = 74
    private let recordInfoViewMaxHeight: CGFloat = 145
    private let locationManager = CLLocationManager()
    private let path = GMSMutablePath()
    private var observation: NSKeyValueObservation?
    private var isRecording = false
    private var lastUserLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        // Listen to the myLocation property of GMSMapView, get first location and invalidate observation.
        observation = mapView.observe(\.myLocation, options: [.new]) { [weak self] mapView, _ in
            guard let location = mapView.myLocation else { return }
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15)
            self?.observation?.invalidate()
        }
        updateUI()
        saveButton.setEnabledWithAnimation(false)
    }
    
    deinit {
        observation?.invalidate()
    }
        
    private func addCoordinateToPath(coordinate: CLLocationCoordinate2D) {
        path.add(coordinate)
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView
    }
    
    private func calculateDistance(from tuple: (lastLocation: CLLocation, newLocation: CLLocation)) -> Double {
        let distanceInMeters = tuple.newLocation.distance(from: tuple.lastLocation)
        return distanceInMeters
    }
    
    private func updateUI() {
        UIView.animate(withDuration: 0.3) {
            self.recordInfoStackView.isHidden = !self.isRecording
            self.mapView.padding = UIEdgeInsets(
                top: self.view.safeAreaInsets.top,
                left: 0,
                bottom: self.isRecording ? self.recordInfoViewMaxHeight : self.recordInfoViewMinHeight,
                right: 0)
        }
    }
    
    private func startRouteRecording() {
        recordButton.setTitle("Stop recording", for: .normal)
        updateUI()
        locationManager.startUpdatingLocation()
    }
    
    private func clear() {
        lastUserLocation = nil
        path.removeAllCoordinates()
        distanceLabel.text = "0 meters"
        mapView.clear()
    }
    
    private func stopRouteRecording() {
        recordButton.setTitle("Start recording", for: .normal)
        updateUI()
        clear()
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - IBActions
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        isRecording = !isRecording
        isRecording ? startRouteRecording() : stopRouteRecording()
        saveButton.setEnabledWithAnimation(isRecording)
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
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        addCoordinateToPath(coordinate: location.coordinate)
        guard let lastLocation = lastUserLocation else {
            lastUserLocation = location
            return
        }
        distanceLabel.text = "\(Int(calculateDistance(from: (lastLocation, location)))) meters"
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with error")
    }

}

