//
//  DataViewController.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 04/10/2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import UIKit

protocol DataViewControllerProtocol: class {
    var presenter: DataScenePresenterProtocol? { get set }
}

class DataViewController: UIViewController, DataViewControllerProtocol {

    private var panRecognizer = UIPanGestureRecognizer()
    
    var presenter: DataScenePresenterProtocol?
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var callsButton: VerticallyButton!
    @IBOutlet weak var websiteButton: VerticallyButton!
    @IBOutlet weak var favouritesButton: VerticallyButton!
    @IBOutlet weak var shareButton: VerticallyButton!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var websiteVIew: UIView!
    @IBOutlet weak var holdView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    
    @IBAction func openDirections(_ sender: Any) {
        presenter?.openDirectionsClicked()
    }
    
    @IBAction func callsTapped(_ sender: Any) {
        presenter?.callsTapped()
    }
    
    @IBAction func websiteTapped(_ sender: Any) {
        presenter?.websiteTapped()
    }
    
    @IBAction func favoritesTapped(_ sender: Any) {
        presenter?.favoritesTapped()
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        presenter?.shareTapped()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        presenter?.closeButtonClicked()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        panRecognizer.addTarget(self, action: #selector(panGesture(_:)))
        holdView.addGestureRecognizer(panRecognizer)
        
    }
    
    @objc func dismissSelf() {
        presenter?.closeButtonClicked()
    }
    
    private func setupUI() {
        view.layer.cornerRadius = 24
        directionsButton.layer.cornerRadius = 9
        callsButton.layer.cornerRadius = 9
        websiteButton.layer.cornerRadius = 9
        favouritesButton.layer.cornerRadius = 9
        shareButton.layer.cornerRadius = 9
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleLabel.text = presenter?.pageTitle
        snippetLabel.text = presenter?.snippet
    }
    
    @objc func panGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        var panGestureAnchorPoint: CGPoint?
        switch gestureRecognizer.state {
        case .began:
            panGestureAnchorPoint = gestureRecognizer.location(in: self.holdView)
        case .changed:
            let gesturePoint = gestureRecognizer.location(in: self.holdView)
            if gesturePoint.y < panGestureAnchorPoint?.y ?? 0 {
                UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut], animations: {
                    self.view.frame = CGRect(x: 0, y: 34,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height)
                    self.holdView.removeGestureRecognizer(self.panRecognizer)
                }, completion: nil)
            
            } else {
            
            }
        default: break
        }
    }
    
}

extension DataViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.photoNames.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PhotoCell.self)
        cell.configure(data: presenter?.photoNames[indexPath.item] ?? "")
            return cell
    }
    
}


extension DataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0: return CGSize(width: collectionView.frame.width * 0.6, height: collectionView.frame.height)
        default: return CGSize(width: collectionView.frame.width * 0.4, height: collectionView.frame.height * 0.5)
        }
    }
}
