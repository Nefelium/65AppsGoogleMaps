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
    
    var viewModel = MapViewModel()
    
    @IBOutlet weak var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    private var secondClusterManager: GMUClusterManager!
    private let clusterItemGenerator = ClusterItemMaker()
    private let transition = PanelTransition()
    private var mapMarker = GMSMarker()
    private var infoMarkerDidAdd = false
    
    private var kClusterItemCount = 10
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBAction func plusAction(_ sender: Any) {
        changeMapZoom(action: .zoomPlus)
    }
    
    @IBAction func minusAction(_ sender: Any) {
        changeMapZoom(action: .zoomMinus)
    }
    
    private func setupButtons() {
        plusButton.layer.cornerRadius = 9
        minusButton.layer.cornerRadius = 9
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateCustomClusterItems(kCameraLatitude: 51.2930419, kCameraLongitude: 14.2038475)
        setupClusterManager()
        setupMapView()
        setupButtons()
        setMarkerForMap(locations: CoordinatesMock().typed)
        viewModel.configure {
            self.setCoordinatesFromModel(data: self.viewModel.data)
        }
    }

    private func changeMapZoom(action: MapZoom) {
        mapMarker.map = nil
        let zoom = mapView.camera.zoom
        switch action {
        case .zoomPlus: mapView.animate(toZoom: zoom + 1)
        case .zoomMinus: mapView.animate(toZoom: zoom - 1)
           }
       }
    
    func setupMapView() {
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
        let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name, snippet: "", locationTypeID: .zero)
        clusterManager.add(item)
      }
    }
    
    func generateCustomClusterItems(kCameraLatitude: Double, kCameraLongitude: Double) {
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: [5, 10, 15, 50, 100, 200, 500, 1000], backgroundColors: [.systemPink, .purple, .purple, .purple, .purple, .purple, .purple, .purple])
            let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
            let renderer = GMUDefaultClusterRenderer(mapView: mapView,
                                                     clusterIconGenerator: iconGenerator)
            secondClusterManager = GMUClusterManager(map: mapView, algorithm: algorithm,
                                               renderer: renderer)
            let extent = 0.2
            for index in 1...kClusterItemCount {
              let lat = kCameraLatitude + extent * randomScale()
              let lng = kCameraLongitude + extent * randomScale()
              let name = "Item \(index)"
              let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name, snippet: "", locationTypeID: .zero)
              secondClusterManager.add(item)
            }
            secondClusterManager.cluster()
            secondClusterManager.setDelegate(self, mapDelegate: self)
    }
    
    private func randomScale() -> Double {
      return Double(arc4random()) / Double(UINT32_MAX) * 3.0 - 2.0
    }
    
    private func setupClusterManager() {
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: [5, 10, 15, 20, 50, 100, 200, 300, 500, 1000], backgroundColors: [.green, .red, .blue, .brown, .darkGray, .lightGray, .magenta, .cyan, .purple, .systemBlue])
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView,
                                                 clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm,
                                           renderer: renderer)
        clusterItemGenerator.prepareItems(clusterManager: clusterManager)
        // Generate and add random items to the cluster manager.
        generateClusterItems(kCameraLatitude: 54.1893423, kCameraLongitude: 45.2810283)
    
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    func setMarkerForMap(locations: [Point]) {

        for location in locations {
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.lattitude), longitude: CLLocationDegrees(location.longitude))
            mapMarker.position = coordinate

            //set image
            let imageName = location.locationTypeID.rawValue
            let image = UIImage(named: imageName)?.resize(maxWidthHeight: 25.0)
            mapMarker.icon = image

            mapMarker.userData = location
            self.generatePOIItem(location.lattitude, long: location.longitude, title: location.title, snippet: location.snippet, id: location.locationTypeID)
        }
        self.clusterManager.cluster()
    }
    
    func setCoordinatesFromModel(data: CoordinatesModel) {
        for item in data.features {
            generatePOIItem(item.geometry.coordinates[1], long: item.geometry.coordinates[0], title: item.properties.title ?? "", snippet: item.properties.snippet ?? "", id: .zero)
        }
        clusterManager.cluster()
    }
    
    func generatePOIItem(_ lat: Double, long: Double, title: String, snippet: String, id: LocationTypes) {
        let item = POIItem(position: CLLocationCoordinate2DMake(lat, long), name: title, snippet: snippet, locationTypeID: id)
        clusterManager.add(item)
    }
    
}

extension MapViewController: GMSMapViewDelegate {
     
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if infoMarkerDidAdd {
            mapMarker.map = nil
            infoMarkerDidAdd = false
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let mapPoint = marker.userData as? POIItem else {
            return false
        }
        if mapPoint.locationTypeID != .zero {
        marker.icon = UIImage(named: mapPoint.locationTypeID.rawValue)?.resize(maxWidthHeight: 25.0)
        } else {
        marker.icon = nil
        }
        marker.title = mapPoint.name
        marker.snippet = mapPoint.snippet
        infoMarkerDidAdd = true
        
        let child = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        
        present(child, animated: true)
        return false
    }
}

extension MapViewController: GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        guard let itemMarker = marker.userData as? POIItem else { return }
        if itemMarker.locationTypeID != .zero {
        marker.icon = UIImage(named: itemMarker.locationTypeID.rawValue)?.resize(maxWidthHeight: 25.0)
        } else {
        marker.icon = nil
        }
    }
}

extension MapViewController: GMUClusterManagerDelegate {
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let camera = GMSCameraPosition.camera(withTarget: cluster.position, zoom: mapView.camera.zoom + 1)
        mapView.animate(to: camera)
        return false
    }

}
