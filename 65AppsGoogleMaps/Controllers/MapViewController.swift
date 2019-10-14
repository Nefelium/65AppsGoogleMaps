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
        //  generateClusterItems()
        
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
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
