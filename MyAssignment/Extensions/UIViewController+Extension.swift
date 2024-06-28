//
//  UIViewController+Extension.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//

import Foundation
import UIKit

extension UIViewController {

    func showToast(message : String){
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.view.backgroundColor = .black
            alert.view.alpha = 0.5
            alert.view.layer.cornerRadius = 15
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                alert.dismiss(animated: true)
            }
        }
     }
