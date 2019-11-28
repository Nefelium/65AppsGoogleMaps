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

protocol MapViewControllerProtocol: class {
    var clusterMaker: Clusterization! { get set }
    var presenter: GoogleMapsPresenterProtocol? { get set }
    func transitionController(title: String, snippet: String)
}

class MapViewController: UIViewController, MapViewControllerProtocol {

    @IBOutlet weak var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    private var renderer: GMUDefaultClusterRenderer!
    
    private var mapMarker = GMSMarker()
    private var infoMarkerDidAdd = false
    var clusterMaker: Clusterization!
    var presenter: GoogleMapsPresenterProtocol?
    
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
        initClusterManager()
        presenter?.setCoordinatesFromModel()
        presenter?.setCoordinatesFromServer()
        makeMarkersWithIcons(marker: mapMarker, locations: CoordinatesMock().typed, clusterManager: clusterManager)
        presenter?.makeClusterItems(clusterManager: clusterManager, clusterItemCount: 40, kCameraLatitude: -19.38201457, kCameraLongitude: 21.39410334)
        self.clusterManager.cluster()
    }

    private func initClusterManager() {
        (clusterManager, renderer) =
        clusterMaker.configureClusterManager(mapView: mapView,
                                             buckets: Constants.buckets,
                                             colors: Constants.colors,
                                             mapPoints: [MapPointType]())
        renderer.delegate = self
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    private func changeMapZoom(action: MapZoom) {
        mapMarker.map = nil
        let zoom = mapView.camera.zoom
        switch action {
        case .zoomPlus: mapView.animate(toZoom: zoom + 1)
        case .zoomMinus: mapView.animate(toZoom: zoom - 1)
           }
       }
    
    private func setupMapView() {
        let location = CoordinatesMock().data[0].position
        mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: 5.0)
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
        presenter?.isMarkerTapped(title: marker.title ?? "", snippet: marker.snippet ?? "")
        return false
    }
    
    func makeMarkersWithIcons(marker: GMSMarker, locations: [MapPointType], clusterManager: GMUClusterManager) {
        for location in locations {
            marker.position = CLLocationCoordinate2DMake(location.lat, location.long)

            //set image
            let imageName = location.locationTypeID.rawValue
            let image = UIImage(named: imageName)?.resize(maxWidthHeight: 25.0)
            marker.icon = image

            marker.userData = location
            presenter?.interactor.generatePOIItem(clusterManager: clusterManager,
                                      position: marker.position,
                                      name: location.name ?? "",
                                      snippet: location.snippet ?? "",
                                      id: location.locationTypeID)
        }
        clusterManager.cluster()
    }
    
    func transitionController(title: String, snippet: String) {
        let transition = PanelTransition()
        guard let child = DataSceneModule().view else { return }
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        child.presenter?.pageTitle = title
        child.presenter?.snippet = snippet
        present(child, animated: true)
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

extension MapViewController: GoogleMapsViewModelOutput {
    
    func showData(data: [MapPointType]) {
        clusterMaker.addItems(to: clusterManager, mapPoints: data)
        clusterManager.cluster()
    }
    
}
