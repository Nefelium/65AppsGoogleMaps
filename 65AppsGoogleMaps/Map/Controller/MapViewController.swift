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
    private var renderer: GMUDefaultClusterRenderer!
    private let transition = PanelTransition()
    private var mapMarker = GMSMarker()
    private var infoMarkerDidAdd = false
    private var clusterMaker = ClusterManager()
    
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
        setupMapView()
        setupButtons()
        (clusterManager, renderer) = clusterMaker.configureClusterManager(mapView: mapView, buckets: [5, 10, 20], colors: [.brown, .cyan, .magenta], mapPoints: CoordinatesMock().data)
        renderer.delegate = self
        clusterManager.setDelegate(self, mapDelegate: self)
        setMarkerForMap(locations: CoordinatesMock().typed)
        viewModel.configure { [weak self] in
            guard let self = self else { return }
            self.viewModel.setCoordinatesFromModel(data: self.viewModel.data, clusterManager: self.clusterManager)
            self.clusterManager.cluster()
        }
        viewModel.generateClusterItems(clusterManager: clusterManager, clusterItemCount: 10, kCameraLatitude: -13.38201457, kCameraLongitude: 24.39410334)
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
    
    func setMarkerForMap(locations: [Point]) {

        for location in locations {
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location.lattitude), longitude: CLLocationDegrees(location.longitude))
            mapMarker.position = coordinate

            //set image
            let imageName = location.locationTypeID.rawValue
            let image = UIImage(named: imageName)?.resize(maxWidthHeight: 25.0)
            mapMarker.icon = image

            mapMarker.userData = location
            viewModel.generatePOIItem(clusterManager: clusterManager, lat: location.lattitude, long: location.longitude, title: location.title, snippet: location.snippet, id: location.locationTypeID)
        }
        self.clusterManager.cluster()
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
        child.viewModel.title = marker.title ?? ""
        child.viewModel.snippet = marker.snippet ?? ""
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
