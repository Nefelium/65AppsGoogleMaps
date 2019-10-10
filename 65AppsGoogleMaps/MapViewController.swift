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

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    private let transition = PanelTransition()


    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 54.3224, longitude: 48.40, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
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
        // Do any additional setup after loading the view.
    }


}

