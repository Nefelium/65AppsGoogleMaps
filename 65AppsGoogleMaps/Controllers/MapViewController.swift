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

class MapViewController: UIViewController, GMSMapViewDelegate, GMUClusterManagerDelegate {
    
    private let transition = PanelTransition()
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    
    private var kClusterItemCount = 10
    
    @IBAction func plusAction(_ sender: Any) {
    }
    
    @IBAction func minusAction(_ sender: Any) {
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 54.3224, longitude: 48.40, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.delegate = self
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 54.3224, longitude: 48.40)
        marker.title = "65apps"
        marker.snippet = "Ulyanovsk"
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let child = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        
        present(child, animated: true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView,
                                    clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm,
                                                          renderer: renderer)

        // Generate and add random items to the cluster manager.
      //  generateClusterItems()

        // Call cluster() after items have been added to perform the clustering
        // and rendering on map.
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }

    // MARK: - GMUClusterManagerDelegate

    private func clusterManager(clusterManager: GMUClusterManager, didTapCluster cluster: GMUCluster) {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
        zoom: mapView.camera.zoom + 1)
      let update = GMSCameraUpdate.setCamera(newCamera)
      mapView.moveCamera(update)
    }

    // MARK: - GMUMapViewDelegate

    private func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
      if let poiItem = marker.userData as? POIItem {
        print("Did tap marker for cluster item \(poiItem.name )")
      } else {
        print("Did tap a normal marker")
      }
      return false
    }

    
    
}
