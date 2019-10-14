//
//  ViewController.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 04/10/2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    private let clusterItemGenerator = ClusterItemMaker()
    private let transition = PanelTransition()
    
    private var kClusterItemCount = 10
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBAction func plusAction(_ sender: Any) {
        changeMapZoom(action: .zoomPlus)
    }
    
    @IBAction func minusAction(_ sender: Any) {
        changeMapZoom(action: .zoomMinus)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClusterManager()
        setupMapView()
        setupButtons()
        setMarkerForMap(locations: CoordinatesMock().typed)
    }

    private func changeMapZoom(action: MapZoom) {
           let zoom = mapView.camera.zoom
           switch action {
           case .zoomPlus: mapView.animate(toZoom: zoom + 1)
           case .zoomMinus: mapView.animate(toZoom: zoom - 1)
           }
       }
    
    func setupMapView() {
//        let camera = GMSCameraPosition.camera(withLatitude: 54.3224, longitude: 48.40, zoom: 17.0)
//        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
//        mapView.delegate = self
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 54.3224, longitude: 48.40)
//        marker.title = "65apps"
//        marker.snippet = "Ulyanovsk"
//        marker.map = mapView
        
        let location = CLLocationCoordinate2D(latitude: CoordinatesMock().data[0].lattitude,
                                              longitude: CoordinatesMock().data[0].longitude)
        mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: 5.0)
    }
    
    func generateClusterItems(kCameraLatitude: Double, kCameraLongitude: Double) {
      let extent = 0.2
      for index in 1...kClusterItemCount {
        let lat = kCameraLatitude + extent * randomScale()
        let lng = kCameraLongitude + extent * randomScale()
        let name = "Item \(index)"
        let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name, snippet: "", locationTypeID: .man)
        clusterManager.add(item)
      }
    }
    
    private func randomScale() -> Double {
      return Double(arc4random()) / Double(UINT32_MAX) * 3.0 - 2.0
    }
    
    private func setupButtons() {
        plusButton.layer.cornerRadius = 9
        minusButton.layer.cornerRadius = 9
    }
    
    private func setupClusterManager() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView,
                                                 clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm,
                                           renderer: renderer)
        clusterItemGenerator.prepareItems(clusterManager: clusterManager)
        // Generate and add random items to the cluster manager.
        generateClusterItems(kCameraLatitude: 54.1893423, kCameraLongitude: 45.2810283)
    
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    func setMarkerForMap(locations: [Point]) -> Void {

        //clear all marker before load again
      //  self.mapView.clear()
        var index = 0
        for location in locations {

            let marker = GMSMarker()
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.lattitude), longitude: CLLocationDegrees(location.longitude))
            marker.position = coordinate

            //set image
            let imageName = location.locationTypeID.rawValue
            let image = UIImage(named: imageName)?.resize(maxWidthHeight: 25.0)
            marker.icon = image

            marker.userData = location
            marker.map = mapView
            mapView.delegate = self
            self.generatePOIItems(location.lattitude, long: location.longitude, title: location.title, snippet: "", id: location.locationTypeID)
           index += 1
        }
        self.clusterManager.cluster()
    }
    
    func generatePOIItems(_ lat: Double, long: Double, title: String, snippet: String, id: LocationTypes) {
        let item = POIItem(position: CLLocationCoordinate2DMake(lat, long), name: title, snippet: "", locationTypeID: id)
        clusterManager.add(item)
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            guard let mapPoint = marker.userData as? POIItem else {
                let mapMarker = GMSMarker()
                mapMarker.map = mapView
                return false
            }
            let mapMarker = GMSMarker(position: mapPoint.position)
            mapMarker.title = mapPoint.name
            mapMarker.snippet = mapPoint.snippet
            mapMarker.map = mapView
            
            let child = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
            child.transitioningDelegate = transition
            child.modalPresentationStyle = .custom
    
            present(child, animated: true)
            return true
        }
}

extension MapViewController: GMUClusterManagerDelegate {
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
        let camera = GMSCameraPosition.camera(withTarget: clusterItem.position, zoom: mapView.camera.zoom)
        let update = GMSCameraUpdate.setCamera(camera)
        mapView.moveCamera(update)
        return false
    }
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let camera = GMSCameraPosition.camera(withTarget: cluster.position, zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(camera)
        mapView.moveCamera(update)
        return false
    }

}
