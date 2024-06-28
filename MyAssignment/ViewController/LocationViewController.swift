//
//  LocationViewController.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var localTimeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    private let viewModel = LocationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        viewModel.requestLocation()
        bindViewModel()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Binding Data with ViewMOdel
    private func bindViewModel() {
        viewModel.permissionHandle = {[weak self] permission in
            switch permission{
            case .denied:
                self?.showToast(message: Dialogs.locationPermission)
                DispatchQueue.main.asyncAfter(deadline: .now()+2){ [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                    
                }
            case .success:
                break
            case .notDetermine:
                break
            }
        }
        viewModel.coordinatesText = { [weak self] text in
            self?.coordinatesLabel.text = text
        }
        
        viewModel.addressText = { [weak self] text in
            self?.addressLabel.text = text
        }
        
        viewModel.timeZoneText = { [weak self] text in
            self?.timeZoneLabel.text = text
        }
        
        viewModel.localTimeText = { [weak self] text in
            self?.localTimeLabel.text = text
        }
        
        viewModel.mapRegion = { [weak self] region in
            self?.mapView.setRegion(region, animated: true)
        }
    }
}
